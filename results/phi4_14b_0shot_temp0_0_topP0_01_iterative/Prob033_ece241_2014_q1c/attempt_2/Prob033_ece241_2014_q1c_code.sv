
module TopModule (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);
always @(*) begin
    // Calculate the sum and capture any carry-out into overflow
    {overflow, s} = a + b;
    
    // Correctly detect signed overflow
    overflow = (a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]);
end

endmodule
