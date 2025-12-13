
module TopModule (
  input in1,
  input in2,
  output logic out
);
always @(posedge clk) begin
  if (in2 == 1'bx) // If in2 has a bubble, consider it as low (0)
    out <= in1 & 1'b0;
  else
    out <= in1 & !in2;
end

// VERILOG-EVAL: endmodule not found
