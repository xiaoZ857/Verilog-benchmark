
module TopModule (
  input clk,
  input reset,
  output reg [4:0] q
);
always @(posedge clk) begin
  if (reset) begin
    q <= 5'b00001;
  end else begin
    // Galois LFSR with taps at positions 5 and 3 (bits 4 and 2)
    // Shift right with feedback to tapped positions
    q[4] <= q[3] ^ q[0];  // Tap at position 5
    q[3] <= q[2];
    q[2] <= q[1] ^ q[0];  // Tap at position 3
    q[1] <= q[0];
    q[0] <= q[4];         // Output bit feeds back
  end
end

endmodule
