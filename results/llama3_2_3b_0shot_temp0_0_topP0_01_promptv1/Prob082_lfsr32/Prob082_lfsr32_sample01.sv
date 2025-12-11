
module TopModule (
  input clk,
  input reset,
  output reg [31:0] q
);
assign q = (reset) ? 32'h1 : q[31:2] ^ q[22:2] ^ q[3:1];

// VERILOG-EVAL: endmodule not found
