
module TopModule (
  input a,
  input b,
  output out
);
  // The output is assigned the logical AND of inputs a and b
  assign out = a & b;
endmodule

// VERILOG-EVAL: errant inclusion of module definition
