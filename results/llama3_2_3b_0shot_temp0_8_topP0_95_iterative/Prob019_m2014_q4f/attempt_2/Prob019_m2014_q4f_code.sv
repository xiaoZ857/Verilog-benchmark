
// Module that implements an AND gate with a bubble on the in2 input
module TopModule (
  // Input signals for in1 and in2
  input in1,
  input in2_bubble,
  // Output signal for 'out'
  output logic out
);

  // Assign 'out' as the negation of '!in2_bubble' ANDed with 'in1'
  assign out = !(!in2_bubble) & in1;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
