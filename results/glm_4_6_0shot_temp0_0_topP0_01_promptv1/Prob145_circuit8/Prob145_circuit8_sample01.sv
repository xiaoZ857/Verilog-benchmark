
module TopModule (
  input clock,
  input a,
  output reg p,
  output reg q
);

always @(*) begin
  if (clock)
    p = a;
end

always @(*) begin
  if (!clock)
    q = p;
end
endmodule
