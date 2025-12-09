

module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);

reg [7:0] q[7:0];

always @(posedge clk) begin
  if (reset) 
    for (int i = 0; i < 8; i++)
      q[i] <= 0;
  else
    for (int i = 0; i < 8; i++)
      q[i] <= d[i];
end

assign q[7:0] = q[7:0];

// VERILOG-EVAL: endmodule not found
