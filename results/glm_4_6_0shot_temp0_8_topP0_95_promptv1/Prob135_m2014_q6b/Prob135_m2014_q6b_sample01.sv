
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);

  always @(*) begin
    case (y)
      3'b000: Y2 = 1'b0;  // From A: next state B(001) or A(000

// VERILOG-EVAL: endmodule not found
