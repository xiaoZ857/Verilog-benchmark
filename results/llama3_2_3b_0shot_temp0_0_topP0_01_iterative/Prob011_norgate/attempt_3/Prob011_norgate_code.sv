
module TopModule (
  input a,
  input b,
  output out
);
// Define the timescale
timescale 1 ns / 10 ps;

// Implement the NOR gate logic
assign out = ~(a & b);

endmodule
