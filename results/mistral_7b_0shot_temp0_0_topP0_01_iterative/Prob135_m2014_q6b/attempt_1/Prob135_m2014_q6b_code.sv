
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);

always @(posedge clk) begin
  case (y)
    0b000 : Y2 <= w; // A -> B transition
    0b001 : Y2 <= y[0]; // A -> A transition
    0b010 : Y2 <= 0'b0; // B -> C transition
    0b011 : Y2 <= 0'b1; // B -> D transition
    0b100 : Y2 <= 0'b0; // C -> E transition
    0b101 : Y2 <= 0'b1; // C -> D transition
    0b110 : Y2 <= 0'b0; // D -> F transition
    0b111 : Y2 <= y[0]; // D -> A transition
    default: Y2 <= 0'bx; // Unknown state, set to an undefined value
  endcase
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
