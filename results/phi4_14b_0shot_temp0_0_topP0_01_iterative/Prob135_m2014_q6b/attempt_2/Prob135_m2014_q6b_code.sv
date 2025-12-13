
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);
always @(*) begin
    case (y)
        3'b000: Y2 = ~w;      // A to B if w=0, stay in A if w=1
        3'b001: Y2 = ~w;      // B to C if w=0, D if w=1
        3'b010: Y2 = ~w;      // C to E if w=0, D if w=1
        3'b011: Y2 = ~w;      // D to F if w=0, A if w=1
        3'b100: Y2 = ~w;      // E stays in E if w=0, D if w=1
        3'b101: Y2 = ~w;      // F to C if w=0, D if w=1
        default: Y2 = 1'bx;   // Undefined state
    endcase
end

endmodule
