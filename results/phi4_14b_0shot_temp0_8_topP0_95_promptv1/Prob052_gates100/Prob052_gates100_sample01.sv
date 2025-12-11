
module TopModule (
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);
assign out_and = &in;
assign out_or = |in;

reg xor_tmp;
always @(*) begin
    xor_tmp = ^in;
end

assign out_xor = xor_tmp;

endmodule
