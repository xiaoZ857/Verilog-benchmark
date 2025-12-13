
module TopModule (
  input [3:0] a,
  input [3:0] b,
  input [3:0] c,
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);
always @(posedge clk) begin
  // Timescale directive should be outside the module definition
  `timescale ins/ns unit ns

  // Parity calculation for inputs b, c, d, and e
  q = ~(b + c + d + e);

  // Encode the input a
  q <= a;
end

// Endmodule declaration
endmodule
