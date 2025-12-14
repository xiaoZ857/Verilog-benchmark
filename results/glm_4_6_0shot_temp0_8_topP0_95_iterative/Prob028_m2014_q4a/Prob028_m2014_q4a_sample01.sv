
module TopModule (
  input d,
  input ena,
  output logic q
);

always @(*) begin
  if (ena) begin
    q = d;
  end
  // When ena is 0, q retains its previous value (implicit latch)
end
endmodule
