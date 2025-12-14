
module TopModule (
  input clk,
  input d,
  input r,
  output logic q
);
always @(posedge clk) begin
    if (r) // If reset is low (0), latch the input data into the flip-flop
        q_internal <= d;
    else // Otherwise, set the flip-flop output to 0 regardless of `d`
        q_internal <= 0;
end

// VERILOG-EVAL: abnormal backticks count
