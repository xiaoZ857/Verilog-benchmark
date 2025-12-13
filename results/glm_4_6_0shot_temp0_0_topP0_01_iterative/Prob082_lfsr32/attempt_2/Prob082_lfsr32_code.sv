
module TopModule (
  input clk,
  input reset,
  output reg [31:0] q
);

  always @(posedge clk) begin
    if (reset) begin
      q <= 32'h1;
    end else begin
      // Galois LFSR shifting right with taps at positions 32, 22, 2, and 1
      // q[0] is the output bit that gets fed back
      q <= {q[31:1], q[0]};
      q[31] <= q[0];  // tap at position 32
      q[21] <= q[22] ^ q[0];  // tap at position 22
      q[1] <= q[2] ^ q[0];  // tap at position 2
      q[0] <= q[1] ^ q[0];  // tap at position 1
    end
  end

endmodule
