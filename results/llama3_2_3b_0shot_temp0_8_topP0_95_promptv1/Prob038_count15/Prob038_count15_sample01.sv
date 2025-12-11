
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
assign q[3:0] = ( ~reset & clk ) ? {15'b1111} : ( ~q + 1'b1 );

endmodule
