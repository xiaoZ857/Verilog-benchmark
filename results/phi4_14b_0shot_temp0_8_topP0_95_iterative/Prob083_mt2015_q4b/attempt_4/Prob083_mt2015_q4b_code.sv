
module TopModule (
  input x,
  input y,
  output z
);
always_ff @(posedge clk or posedge reset) begin
  if (reset)
    current_state <= S1;
  else
    current_state <= next_state;
end

always_comb begin
  // Default behavior: hold the current output unless a transition is necessary
  case (current_state)
    S1: begin
      z = 1'b1; // Output high in state S1
      if (!x) begin
        next_state = S1; // Stay in S1 if x is low
      end else if (x && !y) begin
        next_state = S2; // Transition to S2 if x is high and y is low
      end else if (x && y) begin
        next_state = S4; // Transition to S4 if both x and y are high
      end else begin
        next_state = S1;
      end
    end

    S2: begin
      z = 1'b0; // Output low in state S2
      if (!x) begin
        next_state = S1; // Return to S1 when x is low
      end else if (x && !y) begin
        next_state = S2; // Stay in S2 if x is high and y is low
      end else if (x && y) begin
        next_state = S4; // Transition to S4 when both x and y are high
      end else begin
        next_state = S2;
      end
    end

    S4: begin
      z = 1'b1; // Output high in state S4
      if (!x || !y) begin
        next_state = S1; // Return to S1 when either x or y is low
      end else begin
        next_state = S4; // Stay in S4 as long as both x and y are high
      end
    end

    default: begin
      z = 1'bx;
      next_state = S1;
    end
  endcase
end

endmodule
