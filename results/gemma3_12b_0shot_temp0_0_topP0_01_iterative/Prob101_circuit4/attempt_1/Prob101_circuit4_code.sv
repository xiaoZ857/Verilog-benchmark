
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);

  assign q = (a == 0) ?
             ((b == 0) ?
              ((c == 0) ? d : 1) : 1) : 0;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
