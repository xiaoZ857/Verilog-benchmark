
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
assign q = $signed({0,4,12,20,28,36,44,52,60});

// VERILOG-EVAL: endmodule not found
