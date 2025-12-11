
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);
always @(*) begin
    case (y)
        3'b000: Y2 = 1'b0; // A -> B (0) or A (0)
        3'b001: Y2 = 1'b0; // B -> C (0) or D (0)
        3'b010: Y2 = 1'b0; // C -> E (0) or D (0)
        3'b011: Y2 = 1'b0; // D -> F (0) or A (0)
        3'b100: Y2 = 1'b1; // E -> E (1) or D (0) -> Y2 stays 1
        3'b101: Y2 = 1'b1; // F -> C (0) or D (0) -> Y2 stays 1
        default: Y2 = 1'b0;
    endcase
end
endmodule
