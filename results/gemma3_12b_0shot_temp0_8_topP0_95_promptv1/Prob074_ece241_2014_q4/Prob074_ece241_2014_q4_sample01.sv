
module TopModule (
  input clk,
  input x,
  output z
);
logic ff1_out;
logic ff2_out;
logic ff3_out;
logic x_xor_ff1_out;
logic x_and_ff2_n_out;
logic x_or_ff3_n_out;

always @(posedge clk) begin
  ff1_out <= x_xor_ff1_out;
  ff2_out <= x_and_ff2_n_out;
  ff3_out <= x_or_ff3_n_out;
end

assign x_xor_ff1_out = x ^ ff1_out;
assign x_and_ff2_n_out = x & ~ff2_out;
assign x_or_ff3_n_out = x | ~ff3_out;

assign z = ~(ff1_out & ff2_out & ff3_out);

endmodule
