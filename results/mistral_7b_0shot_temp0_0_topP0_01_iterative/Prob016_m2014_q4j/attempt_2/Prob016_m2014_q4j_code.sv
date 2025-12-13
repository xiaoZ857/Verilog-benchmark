
module TopModule (
  input [3:0] x,
  input [3:0] y,
  output reg [4:0] sum,
  output reg ovf
);

  wire [3:0] cin;
  FullAdder fa0(x[0], y[0], .cin(cin[3]), .sum(sum[0]), .cout(ovf));
  FullAdder fa1(x[1], y[1], .cin(cin[2]), .sum(sum[1]), .cout(cin[3]));
  FullAdder fa2(x[2], y[2], .cin(cin[1]), .sum(sum[2]), .cout(cin[2]));
  FullAdder fa3(x[3], y[3], .cin(cin[0]), .sum(sum[3]), .cout(cin[1]));

endmodule

// VERILOG-EVAL: errant inclusion of module definition
