
module TopModule (
  input clk,
  input reset,
  output reg [4:0] q
);
  // Internal signal to store the next state
  reg [4:0] next_q;

  // Define the tap positions (5 and 3)
  localparam TAP_POS1 = 5;
  localparam TAP_POS2 = 3;

  always @(posedge clk) begin
    if (reset) begin
      // Synchronous reset to all 1s
      q <= 5'b11111;
    end else begin
      // Calculate the next state based on the Galois LFSR logic
      next_q <= q >> 1; // Shift right

      // XOR the tap positions with the LSB output bit (q[0])
      if (q[TAP_POS1 - 1] != q[0]) begin
        next_q[TAP_POS1 - 1] <= 1;
      end else begin
        next_q[TAP_POS1 - 1] <= 0;
      end

      if (q[TAP_POS2 - 1] != q[0]) begin
        next_q[TAP_POS2 - 1] <= 1;
      end else begin
        next_q[TAP_POS2 - 1] <= 0;
      end

      // Update the output register with the next state
      q <= next_q;
    end
  end

// VERILOG-EVAL: endmodule not found
