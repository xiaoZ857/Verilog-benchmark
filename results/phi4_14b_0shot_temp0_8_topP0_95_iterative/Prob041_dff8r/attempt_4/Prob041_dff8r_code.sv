
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
always @(posedge clk) begin
    if (reset) begin
        q <= 8'b00000000; // Synchronously set all bits to zero on reset when clock rises
    end else begin
        q <= d;            // Update register with input data on positive clock edge
    end
end

endmodule
