
module TopModule (
  output zero
);
  
  // Assign 0 to the output 'zero' to ensure it is always LOW.
  assign zero = 0;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
