
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
assign B3_next = state[7]; // From S110 to B0, and from B2 to B3

assign S_next = (state[9] & ack) | (~|state) | (state[0] & ~d) | 
                (state[1] & ~d) | (state[2] & ~d) | (state[3] & ~d);

assign S1_next = state[0] & d;

assign Count_next = state[7];

assign Wait_next = state[8] & done_counting;

assign done = state[8];

assign counting = state[8];

assign shift_ena = state[4] | state[5] | state[6] | state[7];
endmodule
