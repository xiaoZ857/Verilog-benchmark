

module TopModule (
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q
);

always @(posedge clk) begin
    if (areset) q <= 8'd0;
    else q <= d;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
