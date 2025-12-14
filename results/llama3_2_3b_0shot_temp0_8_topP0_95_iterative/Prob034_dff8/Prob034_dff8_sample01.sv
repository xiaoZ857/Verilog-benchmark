
module TopModule (
  input clk,
  input [7:0] d,
  output reg [7:0] q
);
// Define DFFArray8 module
module DFFArray8(
  input clk,
  input [7:0] d[7],
  output reg [7:0] q[7]
);

reg [7:0] dq[7];

always @(posedge clk) begin
  for (int i = 0; i < 8; i++) begin
    dq[i] <= d[i];
  end
end

assign q[0:7] = {dq[0], dq[1], dq[2], dq[3], dq[4], dq[5], dq[6], dq[7]};
endmodule

// Define DFFArray4 module
module DFFArray4(
  input clk,
  input [3:0] d,
  output reg [3:0] q
);

reg [3:0] dq;

always @(posedge clk) begin
  dq <= d;
end

assign q = {dq[0], dq[1], dq[2], dq[3]};
endmodule

// Create a positive edge triggered D flip-flop array
module TopModule (
  input clk,
  input [7:0] d,
  output reg [7:0] q
);

DFFArray8 dut (
  .clk(clk),
  .d(d[7:0]),
  .q(q)
);

DFFArray4 dut2 (
  .clk(clk),
  .d(d[3:0]),
  .q(q[3:0])
);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
