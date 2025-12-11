
module TopModule (
  input clk,
  input in,
  output logic out
);
logic xor_out;

always @(posedge clk) begin
  out <= xor_out;
end

always @(*) begin
  xor_out = in ^ out;
end

endmodule
