
module TopModule (
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] s,
  output reg overflow
);

  always @(*) begin
    // Perform the addition
    {overflow, s} = a + b;
    
    // Detect signed overflow
    // Overflow occurs if:
    // (a[7] == b[7]) and (s[7] != a[7])
    overflow = (a[7] & b[7]) | (~a[7] & ~b[7] & s[7]);
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
