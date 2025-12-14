
module TopModule (
  input clk,
  input a,
  input b,
  output out_assign,
  output reg out_always_comb,
  output reg out_always_ff
);
always_comb: always_comb_block begin
  out_always_comb <= a ^ b;
end

always_ff: always @(posedge clk) begin
  if (out_always_comb != out_always_ff) begin
    out_always_ff <= a ^ b;
  end
end

assign out_assign = a ^ b;

endmodule
