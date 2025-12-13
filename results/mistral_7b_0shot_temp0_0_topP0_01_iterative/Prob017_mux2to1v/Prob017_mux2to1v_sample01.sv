
module TopModule (
  input [99:0] a,
  input [99:0] b,
  input sel,
  output [99:0] out
);
`timescale 1ns / 1ps

always @(posedge clk) begin
  if (sel)
    out <= b;
  else
    out <= a;
end

endmodule
