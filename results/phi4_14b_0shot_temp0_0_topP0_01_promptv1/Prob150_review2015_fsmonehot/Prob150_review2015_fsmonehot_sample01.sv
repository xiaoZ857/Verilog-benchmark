
module TopModule (
  input d,
  input done_counting,
  input ack,
  input [9:0] state, // 10-bit one-hot current state
  output B3_next,
  output S_next,
  output S1_next,
  output Count_next,
  output Wait_next,
  output done,
  output counting,
  output shift_ena
);
assign B3_next = state[7];
assign S_next = (state == 10'b0000000001) | (state[2] & ~d) | (state[4] & ~d) | (state[8] & ack);
assign S1_next = state[1] & d;
assign Count_next = state[3] & done_counting;
assign Wait_next = state[9] & ack;

assign shift_ena = state[7] | state[6] | state[5] | state[4];
assign counting = state[8];
assign done = state[9];

endmodule
