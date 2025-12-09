
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);

always @(*) begin
    // Default to 0
    Y2 = 0;
    
    case (y)
        3'b000: if (w) Y2 = 0; else Y2 = 0; // A -> B or A, y2 remains 0
        3'b001: if (!w) Y2 = 1; else Y2 = 1; // B -> C or D, y2 becomes 1
        3'b010: if (!w) Y2 = 0; else Y2 = 1; // C -> E or D, y2 becomes 0 or remains 1
        3'b011: if (!w) Y2 = 1; else Y2 = 0; // D -> F or A, y2 becomes 1 or 0
        3'b100: Y2 = 0;                   // E stays in E, y2 remains 0
        3'b101: Y2 = 1;                   // F -> C or D, y2 remains 1
    endcase
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
