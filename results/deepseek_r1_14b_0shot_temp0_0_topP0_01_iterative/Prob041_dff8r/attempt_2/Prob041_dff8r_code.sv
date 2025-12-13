
// Set the simulation time units (this should be outside any module)
`timescale 1ns / 1ps

module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);

always @(posedge clk or reset) begin
  if (reset) begin
    q <= 0;
  end else begin
    q <= d;
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
