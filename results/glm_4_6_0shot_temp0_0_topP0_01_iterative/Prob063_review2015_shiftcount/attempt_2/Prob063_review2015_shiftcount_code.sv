
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);

always @(posedge clk) begin
  if (shift_ena) begin
    // Shift in new data to MSB, shift others right
    q <= {data, q[3:1]};
  end
  else if (count_ena) begin
    // Decrement the counter
    q <= q - 1;
  end
  // If neither is enabled, hold the value (implicit)
end

endmodule
