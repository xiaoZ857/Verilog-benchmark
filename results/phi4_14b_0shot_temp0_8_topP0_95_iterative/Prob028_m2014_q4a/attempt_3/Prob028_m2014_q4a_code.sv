
module TopModule (
  input d,
  input ena,
  output logic q
);
always @(*) begin
  if (ena) begin
    q <= d;  // Capture the value of 'd' at 'q' when 'ena' is high
  end
end

// VERILOG-EVAL: endmodule not found
