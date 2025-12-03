

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

assign B3_next = (state == 10'b0000010000); // Transition to B3 from S110

assign S_next = (state == 10'b0000000001) | 
                (state == 10'b0000000100) |
                (state == 10'b0000100000) |
                ((state == 10'b1000000000) & ack); // Transition to S from Wait

assign S1_next = (state == 10'b0000000010) | 
                 (state == 10'b0000001000); // Transition to S1 from S or S11

assign Count_next = (state == 10'b0000010000); // Transition to Count from B3

assign Wait_next = ((state == 10'b0100000000) & done_counting); // Transition to Wait from Count

assign done = (state == 10'b1000000000); // Output logic for 'done' in Wait state

assign counting = (state == 10'b0100000000); // Output logic for 'counting' in Count state

assign shift_ena = (state == 10'b0000001000) | 
                   (state == 10'b0000010000) |
                   (state == 10'b0000100000) |
                   (state == 10'b0001000000); // Output logic for 'shift_ena' in B0, B1, B2, B3 states

endmodule
