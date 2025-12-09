
// Implement a 2-input NOR gate module
module TopModule (
  input in1,
  input in2,
  output logic out
);

// Define the outputs as logic type to ensure proper behavior on clock edges
assign out = ~(in1 & in2);

endmodule // End of the TopModule definition

// VERILOG-EVAL: errant inclusion of module definition
