
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
        // Galois LFSR with taps at positions 5 and 3 (1-indexed)
        // All assignments use current values of q
        q[4] <= q[3] ^ q[0];  // Position 5: XOR of left neighbor (q[3]) with output (q[0])
        q[3] <= q[2];         // Position 4: shift from q[2]
        q[2] <= q[1] ^ q[0];  // Position 3: XOR of left neighbor (q[1]) with output (q[0])
        q[1] <= q[0];         // Position 2: shift from q[0]
        q[0] <= q[4];         // Position 1: shift from q[4] (MSB becomes new LSB)
    end
end

// VERILOG-EVAL: abnormal backticks count
