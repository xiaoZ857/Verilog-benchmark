
module TopModule (
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] s,
  output overflow
);

  // Internal wires to capture the MSB of inputs and sum
  wire a_msb, b_msb, s_msb;

  assign a_msb = a[7];
  assign b_msb = b[7];

  always @(*) begin
    {s[7], s} = a + b; // Capture both the result and overflow carry from addition
    s_msb = s[7];       // MSB of the sum
  end

  // Determine overflow condition
  assign overflow = (a_msb & b_msb & ~s_msb) | (~a_msb & ~b_msb & s_msb);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
