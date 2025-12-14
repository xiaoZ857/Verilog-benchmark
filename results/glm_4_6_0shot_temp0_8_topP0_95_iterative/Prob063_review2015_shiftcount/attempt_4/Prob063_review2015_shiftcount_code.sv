
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);
always @(posedge clk) begin
  if (shift_ena) begin
    // Shift in MSB first: new data goes to bit 3, other bits shift right
    q <= {data, q[3:1]};
  end
  else if (count_ena) begin
    // Decrement the counter
    q <= q - 1;
  end
  // When neither is enabled, maintain current value (implicit)
end

// VERILOG-EVAL: endmodule not found
