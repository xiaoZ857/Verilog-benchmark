
module TopModule (
  input clk,
  input reset,
  output reg [31:0] q
);

  // Internal signal for the new MSB after feedback operation
  wire feedback;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Active-high synchronous reset to set `q` to 32'h1
      q <= 32'h1;
    end else begin
      // Shift right by one bit position
      q[31:1] <= q[30:0];
      
      // Calculate the new MSB using XOR feedback from tapped positions
      // Taps are at positions 32, 22, 2, and 1 (q[31], q[21], q[1], q[0])
      feedback = q[31] ^ q[21] ^ q[1] ^ q[0];
      
      // Set the new MSB
      q[0] <= feedback;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
