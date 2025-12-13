
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
  assign q = (a == 0) ?
             ((b == 0) ?
              ((c == 0) ? d : (c == 1 && d == 0) ? 1 : (c == 1 && d == 1) ? 1 : (c == 0 && d == 1) ? 1 : 0) : (b == 1 && c == 0 && d == 0) ? 1 : (b == 1 && c == 0 && d == 1) ? 1 : (b == 1 && c == 1 && d == 0) ? 1 : (b == 1 && c == 1 && d == 1) ? 1 : 0) : (a == 1) ? (b == 0) ? (c == 0) ? (d == 0) ? 0 : 0 : 0 : (b == 0) ? (c == 0) ? 0 : 0 : (b == 1) ? (c == 0) ? 1 : 1 : 0;
endmodule
