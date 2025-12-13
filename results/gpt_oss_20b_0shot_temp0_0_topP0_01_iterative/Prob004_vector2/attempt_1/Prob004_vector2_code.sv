
//-----------------------------------------------------------------------------
//  TopModule
//  ---------
//  Reverses the byte order of a 32‑bit input vector.
//
//  Example:
//      in  = 32'hA1B2C3D4
//      out = 32'hD4C3B2A1
//
//  The design is fully combinational and synthesizable on any target device.
//-----------------------------------------------------------------------------
module TopModule (
    input  wire [31:0] in,   // 32‑bit input vector
    output wire [31:0] out   // 32‑bit output with bytes reversed
);

    // Byte‑swap using concatenation of sliced byte fields
    assign out = { in[7:0],   // LSB byte becomes MSB
                   in[15:8],  // 2nd byte becomes 3rd
                   in[23:16], // 3rd byte becomes 2nd
                   in[31:24]  // MSB byte becomes LSB
                 };

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
