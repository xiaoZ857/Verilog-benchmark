
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n
);

// Declare intermediate wires for AND gate outputs
wire and1_out, and2_out;

// First layer: Two AND gates
assign and1_out = a & b;
assign and2_out = c & d;

// Second layer: OR gate
assign out = and1_out | and2_out;

// NOT gate for inverted output
assign out_n = ~out;

endmodule
