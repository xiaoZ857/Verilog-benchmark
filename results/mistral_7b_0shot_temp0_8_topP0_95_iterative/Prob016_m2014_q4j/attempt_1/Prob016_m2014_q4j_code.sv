
module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);
module FullAdder (
  input a, b, cin,
  output sum, cout, cof
);

  assign sum = a + b + cin;
  assign cout = (a && b) | (sum && cin) | (cof && !(a ^ b));
  assign cof = cin ^ ((a xor b) xor sum);

endmodule

module TopModule (
  input [3:0] x,
  input [3:0] y,
  output reg [4:0] sum,
  output reg overflow
);

  wire [3:0] cin;
  FullAdder fa0 (x[0], y[0], cin[3], sum[0], cout0, cof0);
  FullAdder fa1 (x[1], y[1] | cout0, cin[2], sum[1], cout1, cof1);
  FullAdder fa2 (x[2], y[2] | cout1, cin[1], sum[2], cout2, cof2);
  FullAdder fa3 (x[3], y[3] | cout2, cin[0], sum[3], cout3, overflow);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
