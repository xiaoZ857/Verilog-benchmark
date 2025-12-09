
//===================================================
//  TopModule
//  ---------
//  4‑input combinational logic
//  out_and : 4‑input AND gate
//  out_or  : 4‑input OR  gate
//  out_xor : 4‑input XOR gate
//===================================================

`timescale 1ns / 1ps          // Optional: define simulation time unit and precision

module TopModule (
    input  wire [3:0] in,     // 4‑bit input vector
    output wire       out_and, // 4‑input AND
    output wire       out_or,  // 4‑input OR
    output wire       out_xor  // 4‑input XOR
);

    // 4‑input AND:  out_and = in[3] & in[2] & in[1] & in[0]
    assign out_and = in[3] & in[2] & in[1] & in[0];

    // 4‑input OR:   out_or  = in[3] | in[2] | in[1] | in[0]
    assign out_or  = in[3] | in[2] | in[1] | in[0];

    // 4‑input XOR:  out_xor = in[3] ^ in[2] ^ in[1] ^ in[0]
    assign out_xor = in[3] ^ in[2] ^ in[1] ^ in[0];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
