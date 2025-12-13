
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
  assign q = (a == 0) ?
             ((b == 0) ?
              ((c == 0) ? d : 0) :
              ((c == 0) ? 0 : (d == 0 ? 0 : 1))) :
             ((b == 0) ?
              ((c == 0) ? 1 : 1) :
              ((c == 0) ? 1 : (d == 0 ? 0 : 1)));

// VERILOG-EVAL: endmodule not found
