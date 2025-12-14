
module TopModule (
  input d,
  input ena,
  output logic q
);
always @(*) begin
  if (ena)
    q <= d;  // Capture the value of 'd' at 'q' when 'ena' is high
end

endmodule
