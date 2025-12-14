
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
  assign q = (a == 0) ?
             ((b == 0) ?
              ((c == 0) ? d : (c == 1 && d == 0) ) : (c == 0 && d == 0) ) : (b == 0 && c == 0 && d == 0);

// VERILOG-EVAL: endmodule not found
