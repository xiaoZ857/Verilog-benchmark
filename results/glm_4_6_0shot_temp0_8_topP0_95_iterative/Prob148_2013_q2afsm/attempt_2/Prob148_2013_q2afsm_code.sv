
module TopModule (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

  // Output logic based on current state
  always @(*) begin
    g = 3'b000;  // Default: no grants
    case (current_state)
      B: g[1] = 1'b1;  // Grant to device 1
      C: g[2] = 1'b1;  // Grant to device 2
      D: g[3] = 1'b1;  // Grant to device 3
      default: g = 3'b000;  // No grants in state A or other states
    endcase
  end

endmodule
