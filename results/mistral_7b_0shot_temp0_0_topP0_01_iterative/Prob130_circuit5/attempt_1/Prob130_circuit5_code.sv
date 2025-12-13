
module TopModule (
  input [3:0] a,
  input [3:0] b,
  input [3:0] c,
  input [3:0] d,
  input [3:0] e,
  output reg [4:0] q
);

always @(posedge clk) begin
  // Parity calculation for inputs b, c, d, and e
  q[4] = ~(b + c + d + e);

  // Encode the input a
  q[3:0] = a;
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
