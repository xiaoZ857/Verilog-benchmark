

module TopModule (
  input clock,
  input a,
  output reg p,
  output reg q
);

assign p = (clock == 1) ? a : 0;
assign q = (clock == 1 && a == 1) || (clock == 0 && a == 0);
endmodule
