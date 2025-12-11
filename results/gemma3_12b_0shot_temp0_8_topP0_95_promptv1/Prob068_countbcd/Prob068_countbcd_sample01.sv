
module TopModule (
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q
);
assign ena[0] = 1'b1;
always @(posedge clk) begin
  if (reset) begin
    q <= 16'b0;
  end else begin
    q <= q + 1;
  end
end

always @(*) begin
  ena[1] = (q[3:0] == 9) && (q[7:4] == 0);
  ena[2] = (q[7:4] == 9) && (q[11:8] == 0);
  ena[3] = (q[11:8] == 9) && (q[15:12] == 0);
end

endmodule
