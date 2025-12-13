
always @(posedge clk) begin
  if (a)
    q <= ~q;
end

// Reset initial state
initial begin
  q <= 0;
  #5;
end

`timescale 1ns / 1ps

module TopModule (
  input clk,
  input a,
  output reg q
);

// Ensure proper indentation for readability
always @(posedge clk) begin
  if (a)
    q <= ~q;
end

initial begin
  q <= 0;
  #5;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
