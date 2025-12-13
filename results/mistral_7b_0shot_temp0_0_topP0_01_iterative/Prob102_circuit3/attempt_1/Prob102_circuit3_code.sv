
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);

assign q = a || b || c || d || q; // OR gate with feedback on c

endmodule

// VERILOG-EVAL: errant inclusion of module definition
