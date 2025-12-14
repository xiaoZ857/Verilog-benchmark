
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);
always @(*) begin
  case(y)
    3'b000: Y2 = ~w; // A -> B (0) or A (1)
    3'b001: Y2 = y[1]; // B -> C (0) or D (1)
    3'b010: Y2 = y[1]; // C -> E (0) or D (1)
    3'b011: Y2 = ~w; // D -> F (0) or A (1)
    3'b100: Y2 = 0; // E stays E (0) or goes to D (1)
    3'b101: Y2 = y[1]; // F -> C (0) or D (1)
    default: Y2 = 0; // Default case, should not occur
  endcase
end

endmodule
