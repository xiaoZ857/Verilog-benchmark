
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
always @(posedge clk) begin
  if (reset) begin
    q <= 4'b0000; // Reset the counter to 0 when reset is active high
  end else if (q < 15) begin
    q <= q + 1; // Increment the counter on positive clock edge, but only if it's not already at its maximum value
  end
end

// VERILOG-EVAL: abnormal backticks count
