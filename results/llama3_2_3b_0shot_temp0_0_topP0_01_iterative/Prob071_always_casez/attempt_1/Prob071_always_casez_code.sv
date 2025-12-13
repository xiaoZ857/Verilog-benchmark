
module TopModule (
  input [7:0] in,
  output reg [2:0] pos
);
// Priority Encoder Module
module PriorityEncoder(
    // Input: 8-bit vector
    input [7:0] in,

    // Output: 3-bit priority value (0-2)
    output reg [2:0] pos
);

// Internal signals for the encoder
reg [1:0] bit;
reg [1:0] prev_bit;

// Initialize internal signals to zero
initial begin
    bit = 0;
    prev_bit = 0;
end

// Clock and reset signal (assuming a positive clock)
always @(posedge clk) begin
    // Check if the input is valid (i.e., not all zeros)
    if (in != 8'b00000000) begin
        // Extract the least significant bit from the input
        bit = in[0];

        // If the current bit is different from the previous one, update pos
        if (bit != prev_bit) begin
            pos = {2'd1, 2'd0};
        end else if (prev_bit == 0) begin
            // If the previous bit was zero and this one is not, set pos to 2'd0
            pos = 2'd0;
        end else if (bit != 0) begin
            // If the current bit is non-zero but the previous one was also non-zero,
            // update pos with the value of the current bit
            pos = {1'd1, 1'd0};
        end
    end

    prev_bit = bit;
end

// Reset signal (assuming a reset input)
always @(posedge reset) begin
    pos <= 2'd0;
end

endmodule
