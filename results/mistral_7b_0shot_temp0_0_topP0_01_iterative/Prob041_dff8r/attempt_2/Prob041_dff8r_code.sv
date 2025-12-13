
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
always @(posedge clk) begin
  if (reset) begin
    q <= 8'b0; // Reset Q to zero on active high reset edge
  end else begin
    q <= d_reg; // Assign new values to output Q on positive edge of clk
  end
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
