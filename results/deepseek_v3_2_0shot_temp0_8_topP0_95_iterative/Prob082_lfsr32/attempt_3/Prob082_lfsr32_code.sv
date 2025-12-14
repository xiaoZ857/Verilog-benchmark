
module TopModule (
  input clk,
  input reset,
  output reg [31:0] q
);
always @(posedge clk) begin
    if (reset) begin
        q <= 32'h1;
    end
    else begin
        // Galois LFSR with taps at positions 32, 22, 2, 1
        // Position 32 (bit 31): XOR with LSB (q[0])
        q[31] <= q[31] ^ q[0];
        
        // Position 22 (bit 21): XOR with LSB (q[0])
        q[21] <= q[21] ^ q[0];
        
        // Position 2 (bit 1): XOR with LSB (q[0])
        q[1] <= q[1] ^ q[0];
        
        // Position 1 (bit 0): XOR with feedback from MSB (q[31])
        q[0] <= q[0] ^ q[31];
        
        // All other bits shift right
        // Handle bits 30 down to 22 (skipping bit 21 which has tap)
        for (integer i = 30; i >= 22; i = i - 1) begin
            q[i] <= q[i+1];
        end
        
        // Handle bits 20 down to 2 (skipping bit 1 which has tap)
        for (integer i = 20; i >= 2; i = i - 1) begin
            q[i] <= q[i+1];
        end
    end
end

endmodule
