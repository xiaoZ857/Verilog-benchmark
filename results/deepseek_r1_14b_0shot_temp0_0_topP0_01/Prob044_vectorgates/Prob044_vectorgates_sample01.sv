
module TopModule (
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output [5:0] out_not
);

// Bitwise OR for each corresponding bit
assign out_or_bitwise = a | b;

// Logical OR (any bit is 1)
assign out_or_logical = (a | b) ? 1 : 0;

// Compute NOT of both vectors and combine into out_not
assign out_not = (~b << 3) | ~a;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
