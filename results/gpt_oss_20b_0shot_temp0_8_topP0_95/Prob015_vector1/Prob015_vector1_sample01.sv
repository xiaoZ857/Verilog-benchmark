
// TopModule.v
// ---------------------------------------------------------------
//  16‑bit half‑word splitter
//
//  Inputs:
//      in   – 16‑bit data word
//
//  Outputs:
//      out_hi – upper 8 bits [15:8]
//      out_lo – lower 8 bits [7:0]
//
//  This module is purely combinational: the outputs change
//  immediately when the input changes.
// ---------------------------------------------------------------

module TopModule (
    input  wire [15:0] in,    // 16‑bit input
    output wire [7:0]  out_hi,  // [15:8]
    output wire [7:0]  out_lo   // [7:0]
);

// Continuous assignments (combinational logic)
assign out_hi = in[15:8];
assign out_lo = in[7:0];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
