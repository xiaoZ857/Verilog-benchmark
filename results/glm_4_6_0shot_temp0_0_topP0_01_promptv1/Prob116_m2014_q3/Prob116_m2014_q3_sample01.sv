
module TopModule (
  input [4:1] x,
  output logic f
);

always @(*) begin
  // Simplified boolean expression from Karnaugh map
  // f = x[1] & x[3] | ~x[1] & x[4]
  f = (x[1] & x[3]) | (~x[1] & x[4]);
end
endmodule
