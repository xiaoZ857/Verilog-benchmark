
module TopModule (
  input logic x,
  input logic y,
  output logic z
);

assign z = (x ^ y) & x;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
