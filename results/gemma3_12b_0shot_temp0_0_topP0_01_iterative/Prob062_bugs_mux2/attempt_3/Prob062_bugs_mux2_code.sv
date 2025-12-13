
module TopModule (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);
  always @(sel, a, b) begin
    out = sel ? b : a;
  end
endmodule
