
module TopModule (
  input x3,
  input x2,
  input x1,
  output f
);

  assign f = (!x3) ? ((!x2) ? (!x1) : (x1)) : ((!x2) ? (!x1) : (x1));

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
