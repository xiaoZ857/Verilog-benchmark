
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);
always @(*) begin
  case(y)
    3'b000: Y2 = 0; // A -> B (0) or A (1), both require y[2] = 0
    3'b001: Y2 = w; // B -> C (0) or D (1), depends on w
    3'b010: Y2 = w; // C -> E (0) or D (1), depends on w
    3'b011: Y2 = ~w; // D -> F (0) or A (1), opposite of w
    3'b100: Y2 = w; // E stays E (0) or goes to D (1), depends on w
    3'b101: Y2 = w; // F -> C (0) or D (1), depends on w
    default: Y2 = 0; // Default case, should not occur
  endcase
end

endmodule
