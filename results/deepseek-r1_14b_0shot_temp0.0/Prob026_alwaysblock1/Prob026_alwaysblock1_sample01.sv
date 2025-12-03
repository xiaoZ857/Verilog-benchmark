

module TopModule (
  input a,
  input b,
  output out_assign,
  output reg out_alwaysblock
);

always @(*) 
  out_alwaysblock = a & b;
  
assign out_assign = a & b;

endmodule
