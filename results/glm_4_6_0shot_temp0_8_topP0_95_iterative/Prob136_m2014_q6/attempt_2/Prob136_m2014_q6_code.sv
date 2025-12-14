
module TopModule (
  input clk,
  input reset,
  input w,
  output z
);

  reg [2:0] current_state, next_state;
  
  // Sequential logic for state transition
  always @(posedge clk) begin
    if (reset) begin
      current_state <= A;
    end else begin
      current_state <= next_state;
    end
  end
  
  // Combinational logic for next state and output
  always @(*) begin
    // Default assignments
    next_state = current_state;
    z = 0;
    
    // Output logic (z=1 in states E and F)
    if (current_state == E || current_state == F) begin
      z = 1;
    end
    
    // Next state logic
    case (current_state)
      A: begin
        if (w == 0) next_state = B;
        else next_state = A;
      end
      B: begin
        if (w == 0) next_state = C;
        else next_state = D;
      end
      C: begin
        if (w == 0) next_state = E;
        else next_state = D;
      end
      D: begin
        if (w == 0) next_state = F;
        else next_state = A;
      end
      E: begin
        if (w == 0) next_state = E;
        else next_state = D;
      end
      F: begin
        if (w == 0) next_state = C;
        else next_state = D;
      end
      default: next_state = A;
    endcase
  end
endmodule
