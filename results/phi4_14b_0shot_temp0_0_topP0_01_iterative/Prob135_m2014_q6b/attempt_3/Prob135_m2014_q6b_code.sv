
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);
always @(*) begin
    case (y)
        3'b000: Y2 = ~w;      // A to B if w=0, stay in A if w=1
        3'b001: Y2 = 1'b1;    // B to C or D, both require Y2 = 1
        3'b010: Y2 = 1'b1;    // C to E or D, both require Y2 = 1
        3'b011: Y2 = w;       // D to F if w=0 (Y2=1), A if w=1 (Y2=0)
        3'b100: Y2 = 1'b1;    // E stays in E or goes to D, both require Y2 = 1
        3'b101: Y2 = 1'b1;    // F to C or D, both require Y2 = 1
        default: Y2 = 1'bx;   // Undefined state
    endcase
end

endmodule
