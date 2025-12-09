

module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);

always @(*) begin
    case (y)
        3'b000, // State A
        3'b001, // State B
        3'b011, // State D
        3'b101: Y2 = w; // States A, B, D, F

        3'b010, // State C
        3'b100: Y2 = ~w; // States C, E

        default: Y2 = y[2]; // Default case to maintain current state for undefined states
    endcase
end
endmodule
