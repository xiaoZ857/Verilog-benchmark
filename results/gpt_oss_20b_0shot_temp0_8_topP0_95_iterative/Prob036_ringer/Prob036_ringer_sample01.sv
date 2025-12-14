
`timescale 1ns/1ps

// ---------------------------------------------------------------------
//  TopModule
//  -----------------------------
//  Purpose:  Control a phone’s ringer and vibration motor.
//  Behaviour: When an incoming call is detected (ring = 1)
//             • If the phone is in vibrate mode (vibrate_mode = 1)
//                 → Turn the motor on (motor = 1) and keep the ringer off
//             • Otherwise (vibrate_mode = 0)
//                 → Turn the ringer on (ringer = 1) and keep the motor off
//  When ring = 0, both outputs are 0 (phone is idle).
// ---------------------------------------------------------------------
module TopModule (
    input  wire ring,          // Incoming call signal (active‑high)
    input  wire vibrate_mode,  // 1 → vibrate mode, 0 → normal mode
    output wire ringer,        // Ringer output (active‑high)
    output wire motor          // Motor output (active‑high)
);

// Combinational logic – the outputs are purely a function of the inputs
assign ringer = ring & ~vibrate_mode;  // Ringer on only when ring and not vibrate
assign motor  = ring & vibrate_mode;   // Motor on only when ring and vibrate

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
