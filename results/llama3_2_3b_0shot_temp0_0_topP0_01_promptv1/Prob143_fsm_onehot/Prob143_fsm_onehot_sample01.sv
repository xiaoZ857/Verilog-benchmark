
module TopModule (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2
);
assign next_state = state[8];
assign out1 = (state[7] == 1'b1) ? 1'b1 : 0'b0;
assign out2 = (state[6] == 1'b1) ? 1'b1 : 0'b0;

endmodule
