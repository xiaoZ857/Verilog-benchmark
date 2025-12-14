
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
always @(posedge clk) // Positive edge-triggered assignment on clk
begin
  if (reset)
    q <= 4'b0001; // Reset the counter to 0 (decimal 1)
  else if (q < 4'hA) // Increment the counter, loop back when it reaches 10 (decimal 10 in hexadecimal)
    q <= q + 1;
end

// VERILOG-EVAL: abnormal backticks count
