
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);
  always @(*) begin
    case (y)
      3'b000: Y2 = w ? 1'b0 : 1'b0; // A -> A (0) or B (0)
      3'b001: Y2 = w ? 1'b0 : 1'b0; // B -> D (0) or C (0)
      3'b010: Y2 = w ? 1'b0 : 1'b1; // C -> D (0) or E (1)
      3'b011: Y2 = w ? 1'b0 : 1'b1; // D -> A (0) or F (1)
      3'b100: Y2 = w ? 1'b0 : 1'b1; // E -> D (0) or E (1)
      3'b101: Y2 = w ? 1'b0 : 1'b0; // F -> D (0) or C (0)
      default: Y2 = 1'b0;
    endcase
  end
endmodule
