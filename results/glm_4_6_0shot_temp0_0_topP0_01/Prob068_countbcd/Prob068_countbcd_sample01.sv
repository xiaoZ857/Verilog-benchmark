
module TopModule (
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q
);

always @(posedge clk) begin
  if (reset) begin
    q <= 16'd0;
  end else begin
    // Increment ones digit
    if (q[3:0] == 4'd9) begin
      q[3:0] <= 4'd0

// VERILOG-EVAL: endmodule not found
