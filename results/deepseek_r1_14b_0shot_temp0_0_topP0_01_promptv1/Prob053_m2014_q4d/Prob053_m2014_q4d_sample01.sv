
module TopModule (
  input clk,
  input in,
  output logic out
);
assign xnor_out = in ^ out;
always @(posedge clk) out <= xnor_out;

endmodule
