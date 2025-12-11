
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);

always @(*) begin
    out = (c == 1'b0) ? (b ^ d) : ~(b ^ d);
end
endmodule
