
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n
);
assign and1 = a & b;
assign and2 = c & d;
assign or_out = and1 | and2;
assign out_n = ~or_out;
always @(posedge clk) begin
    out <= or_out; // If there's no clock in the circuit, remove this line
end
endmodule
