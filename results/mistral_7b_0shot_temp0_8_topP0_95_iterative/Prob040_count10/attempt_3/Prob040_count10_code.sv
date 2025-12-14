
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
always @(posedge clk or posedge reset) // Positive edge-triggered assignments on both clk and reset
begin
  if (reset)
    q <= 4'b0001; // Reset the counter to 0 (decimal 1)
  else if (q < 4'h9) // Increment the counter, loop back when it reaches 9 (decimal 9)
    q <= q + 1;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
