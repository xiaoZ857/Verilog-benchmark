
module TopModule (
  input clk,
  input reset,
  output reg [4:0] q
);

always @(posedge clk) begin
  if (reset) begin
    q <= 5'b11111;  // Reset to all ones
  end else begin
    // Galois LFSR with taps at positions 5 and 3
    // Right shift with XOR feedback
    q[4] <= q[3] ^ q[0];  // Position 5 tap
    q[3] <= q[2];         // Shift
    q[2] <= q[1] ^ q[0];  // Position 3 tap
    q[1] <= q[0];         // Shift
    q[0] <= q[4];         // Output bit becomes new LSB
  end
end

endmodule
