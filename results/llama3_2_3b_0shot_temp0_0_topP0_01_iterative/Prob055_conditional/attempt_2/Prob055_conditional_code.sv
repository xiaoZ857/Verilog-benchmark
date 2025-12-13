
module TopModule (
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  input [7:0] d,
  output reg [7:0] min
);
reg [7:0] min_val = a;
assign min = min_val < b ? min_val : b;
assign min_val = min_val < c ? min_val : c;
assign min_val = min_val < d ? min_val : d;

// VERILOG-EVAL: endmodule not found
