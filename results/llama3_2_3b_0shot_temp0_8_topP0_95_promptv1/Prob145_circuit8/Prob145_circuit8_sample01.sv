
module TopModule (
  input clock,
  input a,
  output reg p,
  output reg q
);
assign p = a & ~q;
always @(posedge clock) begin
    if (a)
        q <= 1'b1;
    else
        q <= 1'b0;
end
endmodule
