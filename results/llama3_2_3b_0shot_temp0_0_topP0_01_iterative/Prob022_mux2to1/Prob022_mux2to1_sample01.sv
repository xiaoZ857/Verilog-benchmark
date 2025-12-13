
module TopModule (
  input a,
  input b,
  input sel,
  output out
);

// Assignments based on the value of 'sel'
assign out = sel ? b : a;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
