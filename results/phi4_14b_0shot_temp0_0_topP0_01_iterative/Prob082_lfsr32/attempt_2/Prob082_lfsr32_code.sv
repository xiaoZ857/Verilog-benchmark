
module TopModule (
  input clk,
  input reset,
  output reg [31:0] q
);
always @(posedge clk) begin
  if (reset) begin
    // Reset the LFSR to initial state when reset is high
    q <= 32'h1;
  end else begin
    // Calculate new MSB using XOR of tapped bits and LSB
    // Taps are at positions: 31, 21, 1, and 0 (0-indexed in Verilog)
    wire feedback = q[31] ^ q[21] ^ q[1] ^ q[0];
    
    // Shift all bits to the right
    q[30:1] <= q[29:0];
    
    // Update tapped positions with feedback
    q[31] <= feedback;
    q[21] <= feedback;
    q[1] <= feedback;
  end
end

endmodule
