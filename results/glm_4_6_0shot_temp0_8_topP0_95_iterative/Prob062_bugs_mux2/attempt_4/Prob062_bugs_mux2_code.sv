
module TopModule (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);
// Original logic using bitwise operations with replication
// When sel is 0: out = (1'b1 & a) | (1'b0 & b) = a
// When sel is 1: out = (1'b0 & a) | (1'b1 & b) = b
assign out = (~sel & a) | (sel & b);

endmodule
