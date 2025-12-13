
module TopModule (
  input p1a,
  input p1b,
  input p1c,
  input p1d,
  input p1e,
  input p1f,
  output p1y,
  input p2a,
  input p2b,
  input p2c,
  input p2d,
  output p2y
);
  // Intermediate wires for the AND gates
  wire and1_out;
  wire and2_out;
  wire and3_out;
  wire and4_out;

  // AND gate 1: p1a AND p1b AND p1c
  assign and1_out = p1a & p1b & p1c;

  // AND gate 2: p1d AND p1e AND p1f
  assign and2_out = p1d & p1e & p1f;

  // OR gate for p1y
  assign p1y = and1_out | and2_out;

  // AND gate 3: p2a AND p2b
  assign and3_out = p2a & p2b;

  // AND gate 4: p2c AND p2d
  assign and4_out = p2c & p2d;

  // OR gate for p2y
  assign p2y = and3_out | and4_out;

endmodule
