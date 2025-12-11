
module TopModule (
  input x,
  input y,
  output z
);

  wire a_out1;
  wire b_out1;
  wire a_out2;
  wire b_out2;
  wire or_out;
  wire and_out;

  module A (
    input x,
    input y,
    output z
  );
    assign z = (x^y) & x;
  endmodule

// VERILOG-EVAL: errant inclusion of module definition
