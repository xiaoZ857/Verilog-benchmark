

module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);

reg [7:0] q[7:0];

always @(posedge clk) begin
  if (reset) q <= 34'd34;
  else q <= d;
end

assign q = q;

// VERILOG-EVAL: endmodule not found
