
module TopModule (
  input clk,
  input reset,
  output reg [4:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        internal_state <= 5'b10101; // Set the initial state to all ones, except for the LSB which is set to 0 and MSB to 1
    end else if ((internal_state[4] & lfsr_poly[4]) || (internal_state[3] & lfsr_poly[3])) begin
        internal_state <= internal_state << 1 ^ 3'b01; // Tap at bit positions 5 and 3, shift right and XOR with LSB
    end else begin
        internal_state <= internal_state << 1; // Shift right without XORing if the condition is not met
    end
end

assign q = internal_state[4:0]; // Assign the output register to the lower 5 bits of the internal state

endmodule
