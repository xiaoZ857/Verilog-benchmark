
// Module to create an AND gate
module TopModule (
  input logic a,  // Positive clock/clk triggered signal 'a'
  input logic b,  // Positive clock/clk triggered signal 'b'
  output logic out // Output of the AND operation
);

// Implement the AND gate logic
assign out = a & b;  // Output is true only if both inputs are true

endmodule // TopModule

// VERILOG-EVAL: errant inclusion of module definition
