
module TopModule (
  input clk,
  input reset,
  output reg [31:0] q
);

  // Always block triggered on positive edge of clock or active high synchronous reset
  always @(posedge clk) begin
    if (reset) begin
      // Reset the LFSR to initial state when reset is high
      q <= 32'h1;
    end else begin
      // Calculate new MSB using XOR of tapped bits and LSB
      // Taps are at positions: 32, 22, 2, and 1 (0-indexed in Verilog)
      // Note: In Verilog, bit indexing starts from 0, so q[31] is the MSB.
      q[31] <= q[30] ^ q[21] ^ q[1] ^ q[0];
      
      // Shift all bits to the right
      q[30:1] <= q[29:0];
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
