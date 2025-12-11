
module TopModule (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);
assign s = a + b;

always @(*) begin
    overflow = (a[7] == b[7]) && (s[7] != a[7]);
end

endmodule
