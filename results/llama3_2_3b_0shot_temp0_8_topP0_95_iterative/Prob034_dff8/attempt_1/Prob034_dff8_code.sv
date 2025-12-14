
module TopModule (
  input clk,
  input [7:0] d,
  output reg [7:0] q
);

// Create a positive edge triggered D flip-flop array
DFFArray8 dut (
  .clk(clk),
  .d(d[3:0]),
  .q(q[3:0])
);

DFFArray4 dut2 (
  .clk(clk),
  .d(d[7:4]),
  .q(q[7:4])
);

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
