
module TopModule (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2
);
assign next_state[0] = state[1] & ~state[2] & ~state[3] & ~state[4] & ~state[5] & ~state[6] & ~state[7] & ~state[8] & ~state[9] | state[0] & ~state[1] & ~state[2] & ~state[3] & ~state[4] & ~state[5] & ~state[6] & ~state[7] & ~state[8] & ~state[9] | state[0] & ~state[1] & ~state[2] & ~state[3] & ~state[4] & ~state[5] & ~state[6] & ~state[7] & ~state[8] & ~state[9] | state[1] & ~state[2] & ~state[3] & ~state[4] & ~state[5] & ~state[6] & ~state[7] & ~state[8] & ~state[9];
assign next_state[1] = state[0] & ~state[2] & ~state[3] & ~state[4] & ~state[5] & ~state[6] & ~state[7] & ~state[8] & ~state[9] | state[2] & ~state[0] & ~state[3] & ~state[4] & ~state[5] & ~state[6] & ~state[7] & ~state[8] & ~state[9] | state[3] & ~state[0] & ~state[1] & ~state[4] & ~state[5] & ~state[6] & ~state[7] & ~state[8] & ~state[9];
assign next_state[2] = state[0] & ~state[1] & ~state[3] & ~state[4] & ~state[5] & ~state[6] & ~state[7] & ~state[8] & ~state[9];
assign next_state[3] = state[0] & ~state[1] & ~state[2] & ~state[4] & ~state[5] & ~state[6] & ~state[7] & ~state[8] & ~state[9];
assign next_state[4] = state[0] & ~state[1] & ~state[2] & ~state[3] & ~state[5] & ~state[6] & ~state[7] & ~state[8] & ~state[9];
assign next_state[5] = state[0] & ~state[1] & ~state[2] & ~state[3] & ~state[4] & ~state[6] & ~state[7] & ~state[8] & ~state[9];
assign next_state[6] = state[5] & ~state[0] & ~state[1] & ~state[2] & ~state[3] & ~state[4] & ~state[7] & ~state[8] & ~state[9] | state[6] & ~state[0] & ~state[1] & ~state[2] & ~state[3] & ~state[4] & ~state[5] & ~state[8] & ~state[9];
assign next_state[7] = state[6] & ~state[0] & ~state[1] & ~state[2] & ~state[3] & ~state[4] & ~state[5] & ~state[8] & ~state[9];
assign next_state[8] = state[5] & ~state[0] & ~state[1] & ~state[2] & ~state[3] & ~state[4] & ~state[6] & ~state[7] & ~state[9];
assign next_state[9] = state[5] & ~state[0] & ~state[1] & ~state[2] & ~state[3] & ~state[4] & ~state[6] & ~state[7] & ~state[8];

assign out1 = state[7] & ~state[0] & ~state[1] & ~state[2] & ~state[3] & ~state[4] & ~state[5] & ~state[6] & ~state[8] & ~state[9] | state[8] & ~state[0] & ~state[1] & ~state[

// VERILOG-EVAL: endmodule not found
