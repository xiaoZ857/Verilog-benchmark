
// ------------------------------------------------------------
//  TopModule
//  Sign‑extends an 8‑bit signed value to 32 bits.
//  The most significant bit (bit[7]) is replicated 24 times
//  and concatenated with the original 8‑bit value.
//
//  No clock is required – the operation is purely combinational.
// ------------------------------------------------------------
`timescale 1ns / 1ps

module TopModule (
    input  wire [7:0]  in,   // 8‑bit signed input
    output wire [31:0] out   // 32‑bit sign‑extended output
);

    // Replication operator: {24{in[7]}} creates 24 copies of the sign bit.
    // Concatenation: {{24{in[7]}}, in} yields the 32‑bit result.
    assign out = {{24{in[7]}}, in};

endmodule

// VERILOG-EVAL: errant inclusion of module definition
