

module TopModule (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);

always @(posedge clk) begin
  // Add two's complement numbers a and b
  int sum = a + b;

  // Check if there was an overflow (carry-out from MSB is 1)
  overflow <= (sum > 255 || sum < -256);

  // Convert the sum back to 8-bit two's complement format and assign to s
  s = {sum[7], {sum[6:0]}>};
end

// VERILOG-EVAL: endmodule not found
