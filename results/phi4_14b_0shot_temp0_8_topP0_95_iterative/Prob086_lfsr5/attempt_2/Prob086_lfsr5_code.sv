
module TopModule (
  input clk,
  input reset,
  output reg [4:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset condition: Set LFSR to 1'b1 at the most significant bit position.
        q <= 5'b00001;
    end else begin
        // Shift right by one position and apply feedback logic with taps at positions 5 and 3.
        
        // First, calculate the feedback using XOR for tap positions (5 and 3)
        // Note: q[4] is tapped, so it gets updated with feedback directly before the shift
        reg new_feedback = q[4] ^ q[2]; // Feedback from taps at positions 5 and 3

        // Shift right by one position
        q[4] <= new_feedback;           // New MSB is feedback
        q[3:1] <= q[2:0];               // Middle bits simply shift right
        
        // The LSB remains unchanged during the shift, effectively shifting in zero
        q[0] <= 1'b0;
    end
end

endmodule
