
module TopModule (
  input clk,
  input reset,
  output reg [4:0] q
);
  // Define the tap positions.  For a 5-bit LFSR, the taps are at positions 5 and 3.
  // Since we are using a 5-bit register, the tap positions are 1 and 3 (remembering that positions are 1-based).
  // These are then translated to 0-based indexing for the register.  So tap positions are 1 and 3.

  always @(posedge clk) begin
    if (reset) begin
      // Synchronous reset to all 1s
      q <= 5'b11111;
    end else begin
      // Shift right and XOR with LSB output
      q <= q >> 1;
      q[0] <= q[1] ^ q[0]; // XOR with LSB output
      q[1] <= q[2];
      q[2] <= q[3];
      q[3] <= q[4];
      q[4] <= q[4];
    end
  end
endmodule
