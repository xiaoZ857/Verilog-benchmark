
module TopModule (
  input clk,
  input reset,
  output reg [4:0] q
);
always @(posedge clk) begin
    if (reset) begin
        q <= 5'b00001;
    end
    else begin
        // Galois LFSR with taps at positions 5 and 3
        // Position 5 (q[4]): XOR with output bit q[0]
        q[4] <= q[3] ^ q[0];
        // Position 4 (q[3]): no tap, shift right
        q[3] <= q[2];
        // Position 3 (q[2]): XOR with output bit q[0]
        q[2] <= q[1] ^ q[0];
        // Position 2 (q[1]): no tap, shift right
        q[1] <= q[0];
        // Position 1 (q[0]): shifts in from MSB (q[4])
        q[0] <= q[4];
    end
end

endmodule
