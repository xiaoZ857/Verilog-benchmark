
module TopModule (
  input clk,
  input x,
  output z
);
wire xor_out, and_out, or_out;
wire q0, q1, q2;

assign xor_out = x ^ q0;
assign and_out = x & (~q1);
assign or_out  = x | (~q2);

always @(posedge clk) begin
    q0 <= xor_out;
    q1 <= and_out;
    q2 <= or_out;
end

assign z = ~(q0 | q1 | q2);

endmodule
