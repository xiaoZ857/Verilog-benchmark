
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);
always @(posedge clk) begin
  if (a == b) begin
    state <= ~state;
  end else begin
    state <= state;
  end
end

assign q = state ? ~(a & b) : (a ^ b);

endmodule
