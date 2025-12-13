
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);
  always @(a, b, c, d) begin
    if ((a == 0 && b == 0) || (a == 1 && b == 1)) begin
      out = 1;
    end else begin
      out = 0;
    end
  end
endmodule
