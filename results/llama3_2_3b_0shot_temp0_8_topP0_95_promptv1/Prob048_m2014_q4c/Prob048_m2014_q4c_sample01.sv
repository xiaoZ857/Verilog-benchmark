
module TopModule (
  input clk,
  input d,
  input r,
  output logic q
);
assign q = (!r & d) ? 1'b1 : !q;

endmodule
