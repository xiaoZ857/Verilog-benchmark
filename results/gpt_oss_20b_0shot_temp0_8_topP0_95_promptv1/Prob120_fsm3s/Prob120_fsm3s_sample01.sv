
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);
reg [1:0] state;
localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

always @(

// VERILOG-EVAL: endmodule not found
