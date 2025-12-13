
module TopModule (
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q
);
always @(posedge areset) begin
  if (areset) begin
    q <= 8'b0; // Reset all DFFs to 0 when areset is high
  end
end

always @(posedge clk) begin
  if (!areset) begin
    q <= d; // Assign the value of 'd' to 'q' on positive edge of clk, only if areset is low
  end
end

// VERILOG-EVAL: endmodule not found
