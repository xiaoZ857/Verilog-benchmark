
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);

always @(*) begin
    case (y)
        3'b000: Y2 = w;       // From A to B or stay in A
        3'b001: Y2 = ~w;      // From B to C or D
        3'b010: Y2 = ~y[3];   // From C to E or D
        3'b011: Y2 = y[1] & ~w; // From D to F or A
        3'b100: Y2 = ~w;      // From E to E or D
        3'b101: Y2 = ~y[3];   // From F to C or D
        default: Y2 = 1'bx;   // Undefined state
    endcase
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
