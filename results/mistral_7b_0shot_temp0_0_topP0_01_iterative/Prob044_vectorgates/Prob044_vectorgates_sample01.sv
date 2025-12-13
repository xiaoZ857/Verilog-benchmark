
module TopModule (
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output [5:0] out_not
);
// Moving the timescale directive outside the module definition
`timescale 1ns / 1ps

always @(posedge clk) begin
  // Bitwise OR of a and b
  out_or_bitwise <= a | b;

  // Logical OR of a and b
  out_or_logical <= a + b;

  // Inverse (NOT) of both vectors
  out_not[0] <= ~a[0]; // Lower half for inverse of a
  out_not[1] <= ~a[1];
  out_not[2] <= ~a[2];

  out_not[5] <= ~b[2]; // Upper half for inverse of b
  out_not[4] <= ~b[1];
  out_not[3] <= ~b[0];
end

endmodule
