
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);
always @(posedge clk) begin
    state <= a ^ b ^ state;
end

assign q = a ^ b ^ state;
endmodule
