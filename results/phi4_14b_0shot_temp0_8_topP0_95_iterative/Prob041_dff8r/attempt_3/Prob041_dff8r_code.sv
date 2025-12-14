
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 8'b00000000; // Synchronously set all bits to zero on reset
    end else begin
        q <= d;            // Update register with input data on clock edge
    end
end

endmodule
