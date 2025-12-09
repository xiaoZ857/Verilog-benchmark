

module TopModule (
  input [15:0] in,
  output [7:0] out_hi,
  output [7:0] out_lo
);

// Split a 16-bit input into lower and higher 8-bit bytes
out_lo = in[7:0];
out_hi = in[15:8];

// VERILOG-EVAL: endmodule not found
