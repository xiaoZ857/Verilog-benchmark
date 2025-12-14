
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

  // State Transition Logic
  assign S_next = (state[9:8] == 2'b00) & ~d; // S to S on d=0, S1 to S on d=0
  assign S1_next = state[8] & d; // S to S1 on d=1, S11 to B0 on d=1

  assign B3_next = state[7]; // B3 is the next state after B2

  assign Count_next = state[6] & done_counting; // B3 to Count when done_counting=1
  assign Wait_next = state[5] & ~ack; // Count to Wait when ack=0, otherwise S
  
  assign B0_next = (state[4] & d); // S110 to B0 on d=1

  // Output Logic
  assign shift_ena = (state[3:0] == 4'b1110) | (state[3:0] == 4'b0111) |
                     (state[3:0] == 4'b0011) | (state[3:0] == 4'b0001);

  assign counting = state[5]; // Counting asserted in Count state

  assign done = state[4] & ack; // Done asserted in Wait when ack=1

endmodule

// VERILOG-EVAL: errant inclusion of module definition
