
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);

reg y_next [2]; // Next state of y[2] and y[1]

always @(posedge clk) begin
  y_next[0] = y[1];
  case (y[2])
    0: y_next[1] = w;
    1: y_next[1] = y[0];
    default: y_next[1] = 3'bx; // Unreachable state, set to 'x' (unknown) value
  endcase
  Y2 <= y[2]; // Assign current state (Y2) to output
  assign y[1] = y_next[0]; // Assign next state of y[1]
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
