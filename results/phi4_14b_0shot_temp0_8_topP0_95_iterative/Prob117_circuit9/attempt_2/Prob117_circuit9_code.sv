
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);
always @(posedge clk) begin
    if (a == 1'b0) begin
        if (q == 3'b111) begin
            q <= 3'b000; // Reset to 0 when q reaches 7
        end else begin
            q <= q + 1'b1; // Increment q
        end
    end
end

endmodule
