
module TopModule (
  input clk,
  input reset,
  output reg [31:0] q
);

always @(posedge clk) begin
  if (reset) begin
    q <= 32'h1;
  end else begin
    // Galois LFSR shifting right
    // Taps at positions 32, 22, 2, 1 (bits 31, 21, 1, 0)
    q[31] <= q[30] ^ q[0];  // Position 32 (MSB) - tapped
    q[30] <= q[29];         // Non-tapped
    q[29] <= q[28];         // Non-tapped
    q[28] <= q[27];         // Non-tapped
    q[27] <= q[26];         // Non-tapped
    q[26] <= q[25];         // Non-tapped
    q[25] <= q[24];         // Non-tapped
    q[24] <= q[23];         // Non-tapped
    q[23] <= q[22];         // Non-tapped
    q[22] <= q[21] ^ q[0];  // Position 22 - tapped
    q[21] <= q[20];         // Non-tapped
    q[20] <= q[19];         // Non-tapped
    q[19] <= q[18];         // Non-tapped
    q[18] <= q[17];         // Non-tapped
    q[17] <= q[16];         // Non-tapped
    q[16] <= q[15];         // Non-tapped
    q[15] <= q[14];         // Non-tapped
    q[14] <= q[13];         // Non-tapped
    q[13] <= q[12];         // Non-tapped
    q[12] <= q[11];         // Non-tapped
    q[11] <= q[10];         // Non-tapped
    q[10] <= q[9];          // Non-tapped
    q[9] <= q[8];           // Non-tapped
    q[8] <= q[

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
