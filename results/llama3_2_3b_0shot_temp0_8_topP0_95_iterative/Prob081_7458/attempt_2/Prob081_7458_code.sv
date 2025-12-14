
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
wire an3;

assign an1 = (p1a & p1b) | (p1c & p1d);
assign an3 = p1e & p1f;
assign an2 = an1 | (an3 & an1); // Use an intermediate signal to drive an2

// Final output for first OR gate
assign p1y = an2;

wire and_a;
wire and_b;

// Assign outputs of second AND gates to intermediate signals
assign and_a = (p2c & p2d);
assign and_b = (and_a & an1);

// Final output for second OR gate
assign p2y = and_b | (an2 & and_b); // Use the intermediate signal again

endmodule
