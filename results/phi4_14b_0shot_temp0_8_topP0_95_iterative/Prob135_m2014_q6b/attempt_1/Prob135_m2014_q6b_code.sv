
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);

always @(*) begin
  case(y)
    3'b000: Y2 = 0; // A -> B or A
    3'b001: Y2 = w; // B -> C or D
    3'b010: Y2 = y[1]; // C -> E or D
    3'b011: Y2 = ~w; // D -> F or A
    3'b100: Y2 = 0; // E stays E or goes to D
    3'b101: Y2 = y[1]; // F -> C or D
    default: Y2 = 0; // Default case, should not occur
  endcase
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
