
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);

always @(posedge clk) begin
  if (reset) begin
    q <= 8'b0;
  end else begin

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
