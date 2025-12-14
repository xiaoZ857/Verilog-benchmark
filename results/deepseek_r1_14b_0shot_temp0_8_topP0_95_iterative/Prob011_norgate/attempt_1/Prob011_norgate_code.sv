
module TopModule (
  input a,
  input b,
  output out
);
  assign out = ~(a | b); // This line implements the NOR functionality
endmodule

// VERILOG-EVAL: errant inclusion of module definition
