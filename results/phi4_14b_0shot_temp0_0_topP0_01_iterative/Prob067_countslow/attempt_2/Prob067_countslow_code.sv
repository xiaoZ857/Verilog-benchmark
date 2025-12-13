
module TopModule (
  input clk,
  input slowena,
  input reset,
  output reg [3:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Synchronous reset to 0
        q <= 4'b0000;
    end else if (slowena) begin
        // Increment counter only when slowena is high
        if (q == 4'b1010) begin
            // Reset to 0 if the current count is 10
            q <= 4'b0000;
        end else begin
            // Otherwise, increment the counter
            q <= q + 1;
        end
    end
end

endmodule
