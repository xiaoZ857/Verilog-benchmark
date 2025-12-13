
module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);
module FullAdder (
  input a, b, cin,
  output sum, cout
);

  always @(posedge clk) begin
    sum = a + b + cin;
    cout = (a & b) | (cin & sum);
  end

endmodule

module TopModule (
  input [3:0] x,
  input [3:0] y,
  input clk,
  output reg [4:0] sum,
  output reg ovf
);

  wire [3:0] cin;
  FullAdder fa0(x[0], y[0], cin[3], sum[0], ovf);
  FullAdder fa1(x[1], y[1], cin[2], sum[1], ovf);
  FullAdder fa2(x[2], y[2], cin[1], sum[2], ovf);
  FullAdder fa3(x[3], y[3], cin[0], sum[3], ovf);

  always @(posedge clk) begin
    assign cin[3] = ovf;
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
