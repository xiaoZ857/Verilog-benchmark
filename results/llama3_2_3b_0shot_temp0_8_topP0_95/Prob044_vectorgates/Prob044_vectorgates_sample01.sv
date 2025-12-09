
module TopModule (
  input [2:0] a,       // 3-bit input vector 'a'
  input [2:0] b,       // 3-bit input vector 'b'
  output [2:0] out_or_bitwise, // bitwise OR of vectors 'a' and 'b'
  output logical out_or_logical, // logical OR of vectors 'a' and 'b'
  output [5:0] out_not         // Not operation on both vectors
);

// Use the positive clock/clk trigger unless otherwise specified.
assign out_or_bitwise = a | b;   // Calculate bitwise-OR of vectors 'a' and 'b'

assign out_or_logical = (a & ~b) | (b & ~a);  // Calculate logical OR of vectors 'a' and 'b'
// Use De Morgan's law to simplify: (~a)^~b or b^(~a)

assign out_not[5:3] = ~b;    // Not operation on vector 'b', output upper half
assign out_not[2:0] = ~(a);  // Not operation on vector 'a' ,output lower half

endmodule

// VERILOG-EVAL: errant inclusion of module definition
