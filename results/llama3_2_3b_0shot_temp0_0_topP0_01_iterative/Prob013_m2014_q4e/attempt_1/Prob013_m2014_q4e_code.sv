
// Implement a 2-input NOR gate

module TopModule (
  input in1,
  input in2,
  output logic out
);

// Define the NOR gate logic
assign out = ~ (in1 & in2);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
