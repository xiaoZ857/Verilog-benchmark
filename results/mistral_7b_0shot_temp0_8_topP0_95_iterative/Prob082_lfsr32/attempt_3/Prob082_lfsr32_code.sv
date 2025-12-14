
module TopModule (
  input clk,
  input reset,
  output reg [31:0] q
);
always @(posedge clk) begin
  if (reset)
    q <= 32'h1;
  else begin
    // Shift bits right
    for (int i = 0; i < 32; i++) begin
      if (!((i == 32) || (i == 22) || (i == 2) || (i == 1)))
        q[i] <= q[i+1];
    end

    // Tap at bit positions 32, 22, 2, and 1
    q[32] <= q[31] ^ q[0];
    q[22] <= q[23] ^ q[0];
    q[ 2] <= q[ 3] ^ q[0];
    q[ 1] <= q[ 2] ^ q[0];
  end
end

// VERILOG-EVAL: endmodule not found
