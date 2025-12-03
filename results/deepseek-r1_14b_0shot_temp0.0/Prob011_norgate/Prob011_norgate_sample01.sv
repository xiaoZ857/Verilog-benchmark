
module TopModule (
  input a,
  input b,
  output out
);
  assign out = ~(a | b); // Alternatively can write `assign out = ~(|a, |b)`
endmodule

// VERILOG-EVAL: errant inclusion of module definition
