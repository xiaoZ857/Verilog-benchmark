
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);
  // 4‑bit shift register / down‑counter
  // On a rising edge of clk:
  //   • If shift_ena is high, shift the contents down one bit and load
  //     the input data into the MSB (bit 3).
  //   • Else if count_ena is high, decrement the 4‑bit value.
  //   • Otherwise, retain the previous value.
  // (The two enables are never asserted simultaneously.)

  always @(posedge clk) begin
    if (shift_ena) begin
      // Shift right and load new data into MSB
      q <= {data, q[3:1]};
    end
    else if (count_ena) begin
      // Decrement the 4‑bit counter (wrap‑around is automatic)
      q <= q - 1'b1;
    end
    // If neither enable is asserted, the register holds its value
  end

endmodule
