
module TopModule (
  input clk,
  input reset,
  output reg [31:0] q
);

  reg feedback;
  
  always @(posedge clk) begin
    if (reset) begin
      q <= 32'h1;
    end else begin
      // Galois LFSR shifting right
      // q[0] is the output bit that gets XORed with tap positions
      // Taps at positions 32, 22, 2, and 1 (bits 31, 21, 1, and 0)
      // For Galois LFSR: tapped bits get XORed with output bit q[0]
      // Untapped bits just shift right
      // MSB gets the feedback
      
      // Calculate feedback (XOR of q[0] with tap positions)
      // Note: bit 0 is always a tap in Galois LFSR
      feedback = q[0] ^ q[1] ^ q[21] ^ q[31];
      
      // Shift right with feedback
      q <= {feedback, q[31:1]};
    end
  end

endmodule
