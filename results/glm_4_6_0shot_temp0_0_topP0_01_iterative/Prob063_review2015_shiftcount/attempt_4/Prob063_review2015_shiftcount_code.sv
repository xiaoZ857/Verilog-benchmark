
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);

always @(posedge clk) begin
  if (shift_ena) begin
    // Shift in new data as MSB, shift existing bits right
    q <= {data, q[3:1]};
  end
  else if (count_ena) begin
    // Decrement the counter
    q <= q - 1;
  end
  // If neither enable is active, hold the current value
end
endmodule
