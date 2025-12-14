
module TopModule (
  input clk,
  input reset,
  output reg [4:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset condition: Set LFSR to 1'b1 at the most significant bit position.
        q <= 5'b10000; // Correct initialization for maximal-length sequence
    end else begin
        // Calculate feedback using XOR for taps at positions 5 and 3
        reg new_feedback = q[4] ^ q[2]; 

        // Shift right, update tapped bits with feedback logic
        q[4] <= new_feedback;           // MSB is updated with the new feedback
        q[3] <= q[3] ^ new_feedback;    // Tapped position 3 also XORs with new feedback
        q[2:1] <= q[1:0];               // Non-tapped middle bits shift right
        q[0] <= q[4];                   // LSB takes the old MSB value before shift
    end
end

endmodule
