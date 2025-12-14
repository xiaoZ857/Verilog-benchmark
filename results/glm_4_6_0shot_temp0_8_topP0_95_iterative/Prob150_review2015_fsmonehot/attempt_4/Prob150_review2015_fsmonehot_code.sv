
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

  // Next state logic
  assign B3_next = state[6];  // B2 -> B3 (always)
  
  assign S_next = (state[0] & ~d) |        // S -> S (when d=0)
                  (state[1] & ~d) |        // S1 -> S (when d=0)
                  (state[3] & ~d) |        // S110 -> S (when d=0)
                  (state[9] & ack);        // Wait -> S (when ack=1)
  
  assign S1_next = state[0] & d;           // S -> S1 (when d=1)
  
  assign Count_next = state[7] |           // B3 -> Count (always)
                     (state[8] & ~done_counting);  // Count -> Count (when done_counting=0)
  
  assign Wait_next = (state[8] & done_counting) |  // Count -> Wait (when done_counting=1)
                    (state[9] & ~ack);            // Wait -> Wait (when ack=0)
  
  // Output logic
  assign shift_ena = state[4] | state[5] | state[6] | state[7];  // B0, B1, B2, B3
  assign counting = state[8];  // Count state
  assign done = state[9];      // Wait state

endmodule
