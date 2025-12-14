
//===================================================================
//  256‑to‑1, 1‑bit wide multiplexer
//  ---------------------------------------------------------------
//  in  : 256‑bit input vector (in[255:0]) – bit 0 is LSB, 255 is MSB
//  sel : 8‑bit selection signal – value 0…255 selects the corresponding bit of `in`
//  out : 1‑bit output – the selected bit of `in`
//  ---------------------------------------------------------------
//  This implementation uses a *variable part‑select* – it is
//  fully synthesizable in modern tools and results in a
//  straightforward combinational logic block.
//
//  The code is compliant with Verilog‑2001 and SystemVerilog
//===================================================================

`timescale 1ns / 1ps

module TopModule (
    input  wire [255:0] in,   // 256 input bits (packed into a vector)
    input  wire [7:0]   sel,  // 8‑bit selector (0‑255)
    output wire         out   // 1‑bit output
);

    // Variable part‑select – selects the bit indexed by `sel`
    assign out = in[sel];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
