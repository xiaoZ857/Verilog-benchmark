
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);

  assign q = (a == 1) ?
              (b == 1) ?
                (c == 1) ?
                  (d == 1) ? 1 : 0
                :
                  (c == 0) ? 1 : 0
              :
                (b == 0) ? 1 : 0;
endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
