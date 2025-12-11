
module TopModule (
  input [3:0] in,
  output out_and,
  output out_or,
  output out_xor
);
assign out_and = in[0] & in[1] & in[2] & in[3];
assign out_or = in[0] | in[1] | in[2] | in[3];
always @(*) begin
    out_xor = ^in;
end

endmodule
