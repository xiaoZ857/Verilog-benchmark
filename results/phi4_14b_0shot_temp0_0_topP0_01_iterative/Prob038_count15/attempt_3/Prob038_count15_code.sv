
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Synchronous reset to 0 when reset is high
        q <= 4'b0000;
    end else begin
        // Increment counter by 1 on each clock cycle and wrap around after reaching 15
        q <= q + 1; // Always increment, let the logic handle wrapping
    end
end

// Additional logic to ensure correct wrapping
always @(*) begin
    if (q == 4'b1111) begin
        q = 4'b0000; // Wrap around to 0
    end
end

endmodule
