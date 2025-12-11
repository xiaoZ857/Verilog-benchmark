
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);
always @(*) begin
    if ((a & b & ~c & ~d) || (a & ~b & c & ~d) || (a & ~b & ~c & d) || (~a & ~b & c & d))
        out = 1;
    else
        out = 0;
endmodule
