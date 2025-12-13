
module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);

  // Define the states
  typedef enum logic [1:0] {
    S0,
    S1,
    S2
  } state_t;

  reg state_t current_state, next_state;

  // State register update on positive clock edge
  always_ff @(posedge clk) begin
    if (!aresetn) begin
      current_state <= S0;
    end else begin
      current_state <= next_state;
    end
  end

  // Next state logic
  always_comb begin
    next_state = current_state; // Default: stay in the current state

    case (current_state)
      S0: begin
        if (x == 1) begin
          next_state = S1;
        end
      end
      S1: begin
        if (x == 0) begin
          next_state = S2;
        end else begin
          next_state = S1; // Stay in S1 if x is 1
        end
      end
      S2: begin
        if (x == 1) begin
          next_state = S1; // Go back to S1 to recognize overlapping sequences
        end else begin
          next_state = S0; // Go back to S0 if x is 0
        end
      end
    endcase
  end

  // Output logic
  always_comb begin
    z = 0; // Default: z is 0
    if (current_state == S2) begin
      z = 1;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
