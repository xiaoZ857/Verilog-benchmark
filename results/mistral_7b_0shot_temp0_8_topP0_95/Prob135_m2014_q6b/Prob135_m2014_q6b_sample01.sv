
module TopModule (
  input [3:1] y, // Current state
  input w,        // Input signal
  output reg Y2   // Next state of y[2]
);

always @(posedge clk) begin
    case (y) // Current state
      3'b000 : Y2 <= w; // A
      3'b001 : Y2 <= y; // B
      3'b010 : Y2 <= 3'b000; // C
      3'b011 : Y2 <= 3'b010; // D
      3'b100 : Y2 <= 3'b101; // E
      3'b101 : Y2 <= 3'b010; // F
    endcase
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
