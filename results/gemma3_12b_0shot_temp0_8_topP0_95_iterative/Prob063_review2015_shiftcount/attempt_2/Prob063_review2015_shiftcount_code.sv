
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);
  always @(posedge clk) begin
    if (shift_ena) begin
      // Shift in data MSB first
      q[3] <= data;
      for (integer i = 3; i > 0; i--) begin
        q[i] <= q[i-1];
      end
    end else if (count_ena) begin
      // Decrement the counter
      q <= q - 1;
    end else begin
      // Hold the current value
      q <= q;
    end
  end
endmodule
