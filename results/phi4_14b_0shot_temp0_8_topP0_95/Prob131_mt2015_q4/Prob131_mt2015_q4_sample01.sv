
module TopModule (
  input x,
  input y,
  output z
);
module A (
    input x,
    input y,
    output z
);
    assign z = (x ^ y) & x;
endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
