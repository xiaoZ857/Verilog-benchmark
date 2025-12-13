
module TopModule (
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output [5:0] out_not
);

// Bitwise OR of each corresponding bit in a and b
assign out_or_bitwise = a | b;

// Logical OR (all bits must be true for the result to be true)
wire a_or_b_bitwise;
assign a_or_b_bitwise = out_or_bitwise;  // Same as bitwise OR since it's already per-bit

// Compute logical OR by ANDing all three bits
assign out_or_logical = &a_or_b_bitwise;

// Inverse of both vectors
wire [2:0] not_a, not_b;
assign not_a = ~a;
assign not_b = ~b;

// Combine inverses into out_not (not_b in upper 3 bits and not_a in lower 3 bits)
assign out_not = {not_b, not_a};

endmodule

// VERILOG-EVAL: errant inclusion of module definition
