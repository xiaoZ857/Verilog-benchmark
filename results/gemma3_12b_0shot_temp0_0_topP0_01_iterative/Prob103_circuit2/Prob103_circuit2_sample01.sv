
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
  assign q = (a == 0) ?
             ((b == 0) ?
              ((c == 0) ? 1 : 0) :
              ((d == 0) ? 0 : 0)) :
             ((b == 0) ?
              ((c == 0) ? 0 : 1) :
              ((d == 0) ? 1 : 0));

// VERILOG-EVAL: endmodule not found
