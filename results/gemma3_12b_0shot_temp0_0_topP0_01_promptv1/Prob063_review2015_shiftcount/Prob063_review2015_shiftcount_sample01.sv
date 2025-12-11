
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);
always @(posedge clk) begin
  if (shift_ena) begin
    q[3:0] <= {data, q[3:1]};
  end else if (count_ena) begin
    q[3:0] <= q[3:0] - 1;
  end else begin
    q[3:0] <= q[3:0];
  end
endmodule
