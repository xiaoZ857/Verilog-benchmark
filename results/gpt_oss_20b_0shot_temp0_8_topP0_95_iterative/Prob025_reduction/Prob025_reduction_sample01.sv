
// 8‑bit even parity generator
// The parity bit is the XOR (exclusive‑or) of all 8 data bits.
//
//   parity = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7]
//
// No clock is required – the result is purely combinational.
//
//--------------------------------------------------------------------
`timescale 1ns / 1ps

module TopModule (
    input  wire [7:0] in,   // 8‑bit data input
    output wire        parity // 1‑bit even‑parity output
);

    // The Verilog reduction operator ^ performs an XOR of all bits in the operand.
    // The result is a single bit that represents even parity.
    assign parity = ^in;

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
