
module TopModule (
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out
);

reg [31:0] prev_in;

always @(posedge clk) begin
    if (reset) begin
        out <= 32'b0;
        prev_in <= 32'b0;
    end else begin
        // Detect falling edges (1 to 0 transitions) and set corresponding output bits
        // prev_in & ~in detects bits that were 1 and are now 0
        // OR with current out to maintain previously set bits
        out <= out | (prev_in & ~in);
        // Store current input for next cycle comparison
        prev_in <= in;
    end
end
endmodule
