
module TopModule (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);

  // Y1 is the input to the flip-flop for state y[1] (B)
  // From the state diagram:
  // If in state A (y[0] = 1), then Y1 = 0 (stay in A)
  // If in state A (y[0] = 1), then Y1 = 0 (stay in A)
  // If in state B (y[1] = 1), then Y1 = 0 (stay in B)
  // If in state B (y[1] = 1), then Y1 = 0 (stay in B)
  // If in state C (y[2] = 1), then Y1 = 0 (stay in C)
  // If in state D (y[3] = 1), then Y1 = 0 (stay in D)
  // If in state E (y[4] = 1), then Y1 = 0 (stay in E)
  // If in state F (y[5] = 1), then Y1 = 0 (stay in F)
  // If in state A (y[0] = 1), then Y1 = 1 (go to B)
  // If in state B (y[1] = 1), then Y1 = 1 (go to C)
  // If in state C (y[2] = 1), then Y1 = 1 (go to E)
  // If in state D (y[3] = 1), then Y1 = 1 (go to F)
  // If in state E (y[4] = 1), then Y1 = 1 (go to D)
  // If in state F (y[5] = 1), then Y1 = 1 (go to C)

  assign Y1 = (y[0] == 1) ? (w == 1) : (y[1] == 1) ? (w == 1) : (y[2] == 1) ? (w == 1) : (y[3] == 1) ? (w == 1) : (y[4] == 1) ? (w == 1) : (y[5] == 1) ? (w == 1) : 0;

  // Y3 is the input to the flip-flop for state y[3] (D)
  // From the state diagram:
  // If in state A (y[0] = 1), then Y3 = 0 (stay in A)
  // If in state A (y[0] = 1), then Y3 = 0 (stay in A)
  // If in state B (y[1] = 1), then Y3 = 0 (stay in B)
  // If in state B (y[1] = 1), then Y3 = 0 (stay in B)
  // If in state C (y[2] = 1), then Y3 = 0 (stay in C)
  // If in state D (y[3] = 1), then Y3 = 0 (stay in D)
  // If in state E (y[4] = 1), then Y3 = 0 (stay in E)
  // If in state F (y[5] = 1), then Y3 = 0 (stay in F)
  // If in state A (y[0] = 1), then Y3 = 0 (stay in A)
  // If in state B (y[1] = 1), then Y3 = 0 (stay in B)
  // If in state C (y[2] = 1), then Y3 = 0 (stay in C)
  // If in state D (y[3] = 1), then Y3 = 0 (stay in D)
  // If in state E (y[4] = 1), then Y3 = 0 (stay in E)
  // If in state F (y[5] = 1), then Y3 = 0 (stay in F)
  // If in state A (y[0] = 1), then Y3 = 0 (stay in A)
  // If in state B (y[1] = 1), then Y3 = 0 (stay in B)
  // If in state

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
