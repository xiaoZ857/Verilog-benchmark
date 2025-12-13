
module TopModule (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);
assign out = (~sel & a) | (sel & b);

always @(posedge clk)
begin
  out <= (~sel & a) | (sel & b);
end

endmodule
