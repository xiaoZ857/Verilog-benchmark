
module TopModule (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);

  // Y1 is the input to the flip-flop for state y[1] (B)
  // Transition from A to B on '1'
  // Transition from A to A on '0'
  // Transition from B to D on '0'
  // Transition from B to C on '1'

  assign Y1 = (y == 6'b000001) ? w : (y == 6'b000010) ? w : 1'b0;

  // Y3 is the input to the flip-flop for state y[3] (D)
  // Transition from A to D on '0'
  // Transition from B to D on '0'
  // Transition from C to D on '0'
  // Transition from D to F on '1'
  // Transition from D to A on '0'

  assign Y3 = (y == 6'b000000) ? 1'b0 : (y == 6'b000010) ? 1'b0 : (y == 6'b000100) ? 1'b0 : (y == 6'b001000) ? (w) : 1'b0;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
