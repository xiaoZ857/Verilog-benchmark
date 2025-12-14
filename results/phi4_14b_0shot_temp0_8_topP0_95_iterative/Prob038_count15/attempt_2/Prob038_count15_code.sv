
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Synchronous active-high reset, set counter to 0
        q <= 4'b0000;
    end else begin
        // Increment the counter on each clock edge and wrap around after reaching maximum value (15)
        if (q == 4'b1111) begin
            q <= 4'b0000; // Wrap around to 0 when it reaches 15
        end else begin
            q <= q + 1;   // Regular increment otherwise
        end
    end
end

endmodule
