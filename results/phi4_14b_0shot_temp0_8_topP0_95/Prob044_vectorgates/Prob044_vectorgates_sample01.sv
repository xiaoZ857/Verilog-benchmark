
module TopModule (
  input [2:0] a,
  input [2:0] b,
  output reg [2:0] out_or_bitwise,
  output reg out_or_logical,
  output reg [5:0] out_not
);

  always @(*) begin
    // Compute the bitwise-OR of a and b
    out_or_bitwise = a | b;

    // Compute the logical-OR of a and b
    out_or_logical = |a || |b; // '|' operator checks if any bit is '1'

    // Compute the inverse (NOT) of both a and b
    out_not[5:3] = ~b;  // Inverse of b in upper half
    out_not[2:0] = ~a;  // Inverse of a in lower half
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
