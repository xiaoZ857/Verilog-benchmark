
module TopModule (
  input clk,
  input reset,
  output reg [31:0] q
);

always @(posedge clk) begin
  if (reset) begin
    q <= 32'h1;
  end else begin
    q[31] <= q[30]; // Shift right all bits except for tapped ones
    q[22] <= q[21] ^ q[0]; // Tap at bit position 32
    q[ 2] <= q[1] ^ q[0]; // Tap at bit position 22
    q[ 1] <= q[0]; // Tap at bit position 2
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
