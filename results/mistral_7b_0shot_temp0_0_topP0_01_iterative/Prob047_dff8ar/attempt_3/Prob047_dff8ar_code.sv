
module TopModule (
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q
);
always @(posedge clk or negedge areset) begin
  if (!areset) begin
    q <= 8'b0; // Reset all DFFs to 0 when areset is low
  end else if (posedge clk) begin
    q <= d; // Assign the value of 'd' to 'q' on positive edge of clk, only if areset is not low
  end
end

// VERILOG-EVAL: abnormal backticks count
