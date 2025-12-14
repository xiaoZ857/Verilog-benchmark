
module TopModule (
  input clk,
  input reset,
  output reg [31:0] q
);
always @(posedge clk) begin
  if (reset)
    q <= 32'h1;
  else begin
    q[32] <= q[31]; // Shift bits right
    q[22] <= q[23] ^ q[0]; // Tap at bit position 22
    q[ 2] <= q[ 3] ^ q[0]; // Tap at bit position 2
    q[ 1] <= q[ 2] ^ q[0]; // Tap at bit position 1
  end
end

// VERILOG-EVAL: endmodule not found
