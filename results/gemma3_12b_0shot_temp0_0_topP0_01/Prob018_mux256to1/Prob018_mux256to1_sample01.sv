

module TopModule (
  input [255:0] in,
  input [7:0] sel,
  output  out
);

always @(posedge clk) begin
  out = in[sel];
endmodule
