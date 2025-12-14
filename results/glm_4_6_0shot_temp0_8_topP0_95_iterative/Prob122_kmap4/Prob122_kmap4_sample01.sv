
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);

  reg xor_ab;
  reg xor_cd;
  
  always @(*) begin
    xor_ab = a ^ b;
    xor_cd = c ^ d;
    out = xor_ab ^ xor_cd;
  end
endmodule
