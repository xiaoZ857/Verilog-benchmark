
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
        // Use temporary variables to hold intermediate values
        reg [4:0] temp_q;

        // Shift all bits right
        temp_q[4] = q[3]; // Shift q[3] to temp_q[4]
        temp_q[3] = q[2]; // Shift q[2] to temp_q[3]
        temp_q[2] = q[1]; // Shift q[1] to temp_q[2]
        temp_q[1] = q[0]; // Shift q[0] to temp_q[1]

        // Update tapped bits using XOR with LSB
        temp_q[4] = temp_q[4] ^ q[0]; // Tap at position 5 (temp_q[4])
        temp_q[2] = temp_q[2] ^ q[0]; // Tap at position 3 (temp_q[2])

        // Calculate new LSB: XOR tapped bits with current LSB
        temp_q[0] = temp_q[4] ^ temp_q[2];

        // Update the register with the temporary values
        q <= temp_q;
    end
end

endmodule
