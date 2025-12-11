
module TopModule (
  input clk,
  input d,
  input ar,
  output logic q
);
assign q = !ar & (clk ? d : 1'b0);

endmodule
