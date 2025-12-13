
module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);
  wire [3:0] c;
  
  assign c[0] = 1'b0;
  
  full_adder fa0 (
    .a(x[0]),
    .b(y[0]),
    .cin(c[0]),
    .s(sum[0]),
    .cout(c[1])
  );
  
  full_adder fa1 (
    .a(x[1]),
    .b(y[1]),
    .cin(c[1]),
    .s(sum[1]),
    .cout(c[2])
  );
  
  full_adder fa2 (
    .a(x[2]),
    .b(y[2]),
    .cin(c[2]),
    .s(sum[2]),
    .cout(c[3])
  );
  
  full_adder fa3 (
    .a(x[3]),
    .b(y[3]),
    .cin(c[3]),
    .s(sum[3]),
    .cout(sum[4])
  );
  
endmodule
