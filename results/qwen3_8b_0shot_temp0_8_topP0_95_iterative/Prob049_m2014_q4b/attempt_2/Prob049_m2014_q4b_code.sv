
module TopModule (
  input clk,
  input d,
  input ar,
  output logic q
);
always @(posedge clk or negedge ar) begin
  if (!ar)
    q <= 1'b0;
  else
    q <= d;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
