
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);

reg state;

always @(posedge clk) begin
  if (a == 0 && b == 0) begin
    state <= ~state;
  end
end

assign q = state ^ b;

endmodule
