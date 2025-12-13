
module TopModule (
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q
);
always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Asynchronous reset: set both ff and q to 0
        ff <= 8'b00000000;
        q <= 8'b00000000;
    end else begin
        // Positive edge triggered D flip-flop behavior
        ff <= d;   // Update internal register with input data
        q <= ff;   // Assign the updated internal register to output
    end
end

endmodule
