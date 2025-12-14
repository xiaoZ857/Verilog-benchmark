
module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);
always @(posedge clk or negedge aresetn) begin
  if (!aresetn) begin
    cur_state <= STATE0; // Reset to initial state
    z <= 0; // Reset output to zero
  end else begin
    case (cur_state)
      STATE0: begin
        if (x == 1)
          cur_state = STATE1;
      end
      STATE1: begin
        if (x == 0)
          cur_state = STATE2;
      end
      STATE2: begin
        if (x == 1) {
          z <= 1; // Output is asserted when state3 is reached
          cur_state = STATE3;
        } else {
          cur_state = STATE0; // Overlapping sequence, return to initial state
        }
      end
      STATE3: begin
        if (x == 0)
          cur_state = STATE0; // Complete sequence, return to initial state
      enddefault: cur_state = STATE0; // Unreachable states or invalid state transition
    end
  end
end

// VERILOG-EVAL: endmodule not found
