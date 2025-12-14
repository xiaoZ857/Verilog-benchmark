
module TopModule (
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out
);

reg [31:0] in_prev;

always @(posedge clk) begin
  if (reset) begin
    out <= 32'b0;
    in_prev <= 32'b0;
  end else begin
    // Detect falling edges (1 -> 0 transition) and latch them
    out <= out | (in_prev & ~in);
    // Store current input for next cycle comparison
    in_prev <= in;
  end
end

endmodule
