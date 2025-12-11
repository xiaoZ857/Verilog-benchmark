
module TopModule (
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  input [7:0] d,
  output reg [7:0] min
);
assign min = {a, b, c, d}[0];

// VERILOG-EVAL: endmodule not found
