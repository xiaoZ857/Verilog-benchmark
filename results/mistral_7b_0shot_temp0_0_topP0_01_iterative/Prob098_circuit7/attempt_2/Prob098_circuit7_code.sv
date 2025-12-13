
always @(posedge clk) begin
  if (a)
    q <= ~q;
end

// Reset initial state
initial begin
  q <= 0;
  #5;
end

// Add timescale directive outside the module definition
`timescale 1ns / 1ps

// Ensure proper indentation for readability
module TopModule (
  input clk,
  input a,
  output reg q
);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
