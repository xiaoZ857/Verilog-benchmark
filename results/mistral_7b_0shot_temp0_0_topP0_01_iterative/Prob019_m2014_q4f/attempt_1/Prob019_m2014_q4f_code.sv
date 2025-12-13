
module TopModule (
  input in1,
  input in2,
  output logic out
);

// Create a temporary variable to hold the inverted value of in2
logic temp;

// AND gate with bubble on in2 input
assign out = in1 & !temp;

// Invert the in2 signal and assign it to the temporary variable
assign temp = ~in2;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
