
module TopModule (
  input d,
  input ena,
  output logic q
);
always @(d ena) begin
  q = d & ena;
end
endmodule
