
module TopModule (
  input clk,
  input a,
  output reg q
);
always @(posedge clk) begin
  if (a == 1'b1) begin
    q <= ~q; // Toggle q when a is high
  end
end

// VERILOG-EVAL: abnormal backticks count
