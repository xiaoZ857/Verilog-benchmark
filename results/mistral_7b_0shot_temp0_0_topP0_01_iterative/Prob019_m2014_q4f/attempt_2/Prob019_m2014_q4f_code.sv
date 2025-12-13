
module TopModule (
  input in1,
  input in2 = 1'b0, // Default value for in2 is 0
  output logic out
);

// AND gate with bubble on in2 input
assign out = in1 & !in2;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
