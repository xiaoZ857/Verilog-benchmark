
module TopModule (
  input [99:0] a,
  input [99:0] b,
  input sel,
  output [99:0] out
);
always @(posedge clk) begin
  if (sel)
    out = b;
  else
    out = a;
end

// Adding timescale directive at the beginning
`timescale 1ns / 1ps

endmodule
