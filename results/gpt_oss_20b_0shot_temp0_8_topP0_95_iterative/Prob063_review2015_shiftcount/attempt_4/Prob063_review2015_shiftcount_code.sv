
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);
always @(posedge clk) begin
  if (shift_ena) begin
    q <= {data, q[2:0]};      // shift in MSB first
  end else if (count_ena) begin
    q <= q - 1'b1;            // decrement the 4‑bit counter
  end
end

endmodule
