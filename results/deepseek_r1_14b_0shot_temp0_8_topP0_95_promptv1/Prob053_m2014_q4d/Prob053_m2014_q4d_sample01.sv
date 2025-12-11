
module TopModule (
  input clk,
  input in,
  output logic out
);
assign d = in ^ out;
always @(posedge clk) begin
    out <= d;
end
endmodule
