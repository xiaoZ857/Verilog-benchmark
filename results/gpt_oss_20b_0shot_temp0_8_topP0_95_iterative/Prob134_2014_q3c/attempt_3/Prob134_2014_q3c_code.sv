
module TopModule (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);
always_comb begin
  // Determine next state LSB Y0 based on current state y and input x
  case (y)
    3'b000: Y0 = x;        // 000 → 000 (x=0) or 001 (x=1)
    3'b001: Y0 = ~x;       // 001 → 001 (x=0) or 100 (x=1)
    3'b010: Y0 = x;        // 010 → 010 (x=0) or 001 (x=1)
    3'b011: Y0 = ~x;       // 011 → 001 (x=0) or 010 (x=1)
    3'b100: Y0 = ~x;       // 100 → 011 (x=0) or 100 (x=1)
    default: Y0 = 1'b0;    // Default case (should not occur)
  endcase

  // Output z is high for states 011 and 100 regardless of x
  z = (y == 3'b011 || y == 3'b100) ? 1'b1 : 1'b0;
end
endmodule
