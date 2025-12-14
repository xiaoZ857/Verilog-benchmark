
module TopModule (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2
);
  assign next_state[0] = (state[0] == 1) | (state[2] == 1) | (state[3] == 1) | (state[4] == 1) | (state[6] == 1) | (state[7] == 1) | (state[8] == 1) | (state[9] == 1);
  assign next_state[1] = (state[0] == 1) & (in == 1) | (state[1] == 1) | (state[8] == 1);
  assign next_state[2] = (state[1] == 1) & (in == 1) | (state[0] == 1);
  assign next_state[3] = (state[2] == 1) & (in == 1) | (state[0] == 1);
  assign next_state[4] = (state[3] == 1) & (in == 1) | (state[0] == 1);
  assign next_state[5] = (state[4] == 1) & (in == 1) | (state[9] == 1) | (state[0] == 1);
  assign next_state[6] = (state[5] == 1) & (in == 1) | (state[7] == 1) | (state[0] == 1);
  assign next_state[7] = (state[6] == 1) & (in == 1) | (state[7] == 1) | (state[0] == 1);
  assign next_state[8] = (state[5] == 1) & (in == 1) | (state[8] == 1) | (state[0] == 1);
  assign next_state[9] = (state[4] == 1) & (in == 1) | (state[9] == 1) | (state[0] == 1);

  assign out1 = (state[7] == 1) | (state[8] == 1);
  assign out2 = (state[9] == 1) | (state[7] == 1);

endmodule
