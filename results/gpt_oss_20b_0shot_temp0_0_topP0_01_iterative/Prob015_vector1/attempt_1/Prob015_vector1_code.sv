
// ------------------------------------------------------------
//  TopModule.v
//  ------------------------------------------------------------
//  Description:
//      Split a 16‑bit half‑word into two 8‑bit bytes.
//
//  Ports:
//      in      : 16‑bit input half‑word
//      out_hi  : upper 8 bits  [15:8]
//      out_lo  : lower 8 bits  [7:0]
//
//  Note:
//      This is a purely combinational module – no clock edge
//      is involved.  The outputs change immediately when the
//      input changes.
//
//  Author:  <Your Name>
//  Date:    <Date>
// ------------------------------------------------------------

`timescale 1ns / 1ps

module TopModule (
    input  wire [15:0] in,      // 16‑bit input half‑word
    output wire [7:0]  out_hi,  // upper byte  [15:8]
    output wire [7:0]  out_lo   // lower byte  [7:0]
);

    // Continuous assignments – the outputs are always
    // the corresponding slices of the input.
    assign out_hi = in[15:8];
    assign out_lo = in[7:0];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
