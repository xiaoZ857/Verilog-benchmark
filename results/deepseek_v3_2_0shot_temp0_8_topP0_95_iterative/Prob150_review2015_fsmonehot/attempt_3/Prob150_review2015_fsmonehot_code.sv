
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
assign S_next = (state[0] & ~d) |        // S --d=0--> S
                (state[1] & ~d) |        // S1 --d=0--> S
                (state[3] & ~d) |        // S110 --d=0--> S
                (state[9] & ack);        // Wait --ack=1--> S

assign S1_next = (state[0] & d) |        // S --d=1--> S1
                 (state[1] & d & ~state[2]); // S1 --d=1--> S11 (but S1_next should only be for S1 state)

// Wait, I need to reconsider S1_next. Looking at the transitions:
// From S (state[0]) when d=1 -> S1
// From S1 (state[1]) when d=0 -> S (already covered in S_next)
// From S1 (state[1]) when d=1 -> S11 (not S1)
// So S1_next should only be from S when d=1
assign S1_next = state[0] & d;

// S11_next would be: state[1] & d
// S110_next would be: state[2] & ~d

assign Count_next = state[7] & ~state[8]; // From B3 (state[7]) always goes to Count

assign Wait_next = state[8] & done_counting; // From Count (state[8]) when done_counting=1

assign B3_next = state[6]; // From B2 (state[6]) always goes to B3

// Output logic
assign shift_ena = state[4] | state[5] | state[6] | state[7]; // B0, B1, B2, B3
assign counting = state[8]; // Count state
assign done = state[9]; // Wait state
endmodule
