
module TopModule (
  input clk,
  input reset,
  output reg [4:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset the LFSR to 1 (binary 00001)
        q <= 5'b00001;
    end else begin
        // Perform XOR on tapped bits with LSB before shifting
        q[4] <= q[3]; // Shift q[3] to q[4]
        q[3] <= q[2]; // Shift q[2] to q[3]
        q[2] <= q[1]; // Shift q[1] to q[2]
        q[1] <= q[0]; // Shift q[0] to q[1]

        // Calculate new LSB: XOR tapped bits with current LSB
        q[0] <= q[4] ^ q[2];
    end
end

endmodule
