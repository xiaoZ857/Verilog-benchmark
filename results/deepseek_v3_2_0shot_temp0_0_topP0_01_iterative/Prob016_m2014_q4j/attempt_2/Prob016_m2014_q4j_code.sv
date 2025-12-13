
module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);
wire [3:0] c;
  
  assign c[0] = 1'b0;
  
  // Define full adder logic directly instead of instantiating a missing module
  assign {c[1], sum[0]} = x[0] + y[0] + c[0];
  assign {c[2], sum[1]} = x[1] + y[1] + c[1];
  assign {c[3], sum[2]} = x[2] + y[2] + c[2];
  assign {sum[4], sum[3]} = x[3] + y[3] + c[3];
  
endmodule
