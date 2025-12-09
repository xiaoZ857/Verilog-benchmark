
module TopModule (
  input wire a,
  input wire b, // Note: 'b' is not used in the final expression.
  input wire c,
  input wire d,
  output wire q
);

assign q = (a) ? (c | d) : (c & d);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
