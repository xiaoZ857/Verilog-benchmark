
module TopModule (
  input a,
  input b,
  output out
);
// AND gate module
module and_gate (
  input a, // input signal A
  input b, // input signal B
  output out // output signal (AND result)
);

// AND operation
assign out = a & b; // a AND b

endmodule and_gate
