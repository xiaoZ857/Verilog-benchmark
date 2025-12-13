
module TopModule (
  input clk,
  input reset,
  output reg [9:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 10'b0000000000; // Reset the counter to 0 synchronously on reset
    end else begin
        if (q == 10'd999) begin
            q <= 10'b0000000000; // Wrap around to 0 after reaching 999
        end else begin
            q <= q + 1; // Increment the counter otherwise
        end
    end
end

endmodule
