#!/usr/bin/env python3
"""
Static Analyzer for Verilog Code - Detect Simulation-Killing Patterns

This script performs static analysis to identify Verilog code patterns that
will cause simulation to hang or crash, allowing us to skip them safely.
"""

import re
import sys
from typing import List, Tuple, Optional

def will_hang_simulation(verilog_code: str) -> Tuple[bool, Optional[str]]:
    """
    Check for patterns that cause simulation to hang.
    """

    lines = [line.strip() for line in verilog_code.split('\n') if line.strip()]

    # Pattern 1: Direct combinational loop in assign statement
    for line in lines:
        if line.startswith('assign '):
            # Look for pattern where a signal depends on itself in the same assign statement
            match = re.match(r'assign\s+(\w+)\s*=.*\b\1\b', line)
            if match:
                signal = match.group(1)
                return True, f"Direct combinational loop: {signal} depends on itself in assign statement"

    # Pattern 2: Complex feedback loops through assign and always blocks
    # Specifically: assign A = B; and always block uses A to set B
    assign_signals = {}
    for line in lines:
        if line.startswith('assign '):
            match = re.match(r'assign\s+(\w+)\s*=\s*([^;]+)', line)
            if match:
                signal = match.group(1)
                expression = match.group(2)
                assign_signals[signal] = expression

    # Look for patterns like: assign prev_state = state; and always blocks using prev_state to update state
    for signal, expression in assign_signals.items():
        if '=' in expression:  # Simple assignment
            dep = expression.split('=')[0].strip()
            # Check if there are always blocks that use the assigned signal to update the dependency
            for line in lines:
                if 'always' in line and f'<=' in line and signal in line and dep in line:
                    return True, f"Complex feedback loop: {signal} and {dep} create circular dependency"

    return False, None

def check_file(file_path: str) -> Tuple[bool, Optional[str]]:
    """Check a single file for simulation-hanging patterns"""
    try:
        with open(file_path, 'r') as f:
            content = f.read()
    except Exception as e:
        return True, f"Error reading file: {e}"

    return will_hang_simulation(content)

def main():
    if len(sys.argv) != 2:
        print("Usage: python static_analyzer.py <verilog_file>")
        sys.exit(1)

    file_path = sys.argv[1]
    will_hang, reason = check_file(file_path)

    if will_hang:
        print(f"HANG DETECTED: {reason}")
        sys.exit(1)
    else:
        print("SAFE: No simulation-hanging patterns detected")
        sys.exit(0)

if __name__ == "__main__":
    main()