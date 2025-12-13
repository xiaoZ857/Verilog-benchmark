
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
always @(posedge clk) begin
  if (reset) begin
    q <= 8'b0; // Reset all Q bits to zero on active high reset edge
  end else begin
    q[7] <= d[7]; // Assign new values to output Q[7] on positive edge of clk
    q[6:1] <= q[7:2]; // Propagate previous values to lower bits
    q[0] <= d[0]; // Assign new value to output Q[0] from input d[0]
  end
end

// VERILOG-EVAL: endmodule not found
