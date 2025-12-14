
module TopModule (
  input [4:1] x,
  output logic f
);
always_comb begin
  f = (~x[2] & ~x[4]) | 
      (x[1] & x[2] & ~x[3]) | 
      (x[1] & ~x[2] & ~x[3]);
end

endmodule
