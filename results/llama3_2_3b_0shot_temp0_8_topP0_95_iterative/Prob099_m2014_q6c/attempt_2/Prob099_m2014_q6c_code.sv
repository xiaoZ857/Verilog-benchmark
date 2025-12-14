
module TopModule (
  input [6:1] y,
  input w,
  output logic Y2,
  output logic Y4
);

// States and transitions of the state machine
// A
assign Y2 = (y[5] == 0 && y[6] == 0) || (y[3] == 1); // next state is B
assign Y2 = (y[5] == 0 && y[6] == 1) || (y[4] == 1); // next state is A

// B
assign Y2 = (y[5] == 1 && y[6] == 0) || (y[3] == 0); // next state is C
assign Y2 = (y[5] == 1 && y[6] == 1) || (y[4] == 0); // next state is D

// C
assign Y2 = (y[5] == 0 && y[6] == 1) || (y[3] == 0); // next state is E
assign Y2 = (y[5] == 0 && y[6] == 1) || (y[4] == 1); // next state is D

// D
assign Y2 = (y[5] == 1 && y[6] == 0) || (y[3] == 1); // next state is A
assign Y2 = (y[5] == 1 && y[6] == 1) || (y[4] == 0); // next state is D

// E
assign Y2 = (y[5] == 0 && y[6] == 1) || (y[3] == 0); // next state is C
assign Y2 = (y[5] == 0 && y[6] == 1) || (y[4] == 1); // next state is D

// F
assign Y2 = (y[5] == 1 && y[6] == 0) || (y[3] == 0); // next state is E
assign Y2 = (y[5] == 1 && y[6] == 1) || (y[4] == 1); // next state is D

// F to E transition
assign Y4 = (!w && y[5] == 1 && y[6] == 0); // next state is E
assign Y4 = (!w && y[5] == 1 && y[6] == 1) || (y[4] == 0); // next state is D

// A to B transition
assign Y4 = (w && y[2] == 1 && y[3] == 0 && y[4] == 0); // next state is B
assign Y4 = (w && y[2] == 1 && y[3] == 0 && y[4] == 1) || (y[5] == 1); // next state is A

// A to D transition
assign Y4 = (w && y[2] == 1 && y[3] == 0 && y[4] == 1); // next state is D
assign Y4 = (w && y[2] == 1 && y[3] == 1 && y[4] == 0) || (y[5] == 0); // next state is A

// B to C transition
assign Y4 = (!w && y[2] == 0 && y[3] == 0 && y[4] == 0); // next state is C
assign Y4 = (!w && y[2] == 0 && y[3] == 1 && y[4] == 0) || (y[5] == 1); // next state is D

// B to D transition
assign Y4 = (!w && y[2] == 0 && y[3] == 0 && y[4] == 1); // next state is D
assign Y4 = (!w && y[2] == 0 && y[3] == 1 && y[4] == 0) || (y[5] == 0); // next state is A

// C to E transition
assign Y4 = (!w && y[2] == 0 && y[3] == 0 && y[4] == 1); // next state is E
assign Y4 = (!w && y[2] == 0 && y[3] == 1 && y[4] == 0

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
