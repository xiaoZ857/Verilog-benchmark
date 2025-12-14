
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 4'b0000; // Reset to 0 when active high reset occurs
    end else begin
        if (q == 4'd9)
            q <= 4'b0000; // Wrap around to 0 when count reaches 10
        else
            q <= q + 1;   // Increment the counter by 1
    end
end

endmodule
