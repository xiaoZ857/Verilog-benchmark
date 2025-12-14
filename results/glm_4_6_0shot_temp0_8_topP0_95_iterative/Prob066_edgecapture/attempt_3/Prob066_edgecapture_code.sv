
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
    in_prev <= in;  // Initialize with current input on reset
  end else begin
    // Detect falling edges (1 in previous cycle to 0 in current cycle)
    // and latch them by OR-ing with current output
    out <= out | (in_prev & ~in);
    // Store current input for next cycle comparison
    in_prev <= in;
  end
end

endmodule
