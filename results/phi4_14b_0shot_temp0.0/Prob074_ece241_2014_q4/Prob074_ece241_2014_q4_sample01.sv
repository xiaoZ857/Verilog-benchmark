

module TopModule (
  input clk,
  input x,
  output z
);

reg d1, d2, d3;
wire q1, q2, q3, xor_out, and_out, or_out;

assign xor_out = x ^ q1;
assign and_out = x & ~q2;
assign or_out = x | ~q3;

always @(posedge clk) begin
    d1 <= xor_out;
    d2 <= and_out;
    d3 <= or_out;
end

assign q1 = d1;
assign q2 = d2;
assign q3 = d3;

assign z = ~(q1 | q2 | q3);

endmodule
