
module TopModule (
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q
);
always @(areset) begin
  if (areset) begin
    q <= 0;
  end
end

always @(posedge clk) begin
  if (!areset) begin
    q <= d;
  end
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
