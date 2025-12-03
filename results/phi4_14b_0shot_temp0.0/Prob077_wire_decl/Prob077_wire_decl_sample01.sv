

module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n
);

wire and1_out;
wire and2_out;

and (and1_out, a, b);       // First AND gate with inputs a and b
and (and2_out, c, d);       // Second AND gate with inputs c and d

or  (out, and1_out, and2_out); // OR gate combining the outputs of both AND gates

not (out_n, out);           // NOT gate inverting the output 'out'
endmodule
