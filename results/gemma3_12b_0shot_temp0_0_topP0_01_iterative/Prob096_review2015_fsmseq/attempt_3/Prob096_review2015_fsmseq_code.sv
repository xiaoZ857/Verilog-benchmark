
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);
  // Define states
  typedef enum logic [1:0] {
    S0, // Initial state
    S1, // Received '1'
    S2, // Received '11'
    S3, // Received '110'
    S4  // Received '1101'
  } state_t;

  state_t current_state, next_state;

  // Register to hold the current state
  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      current_state <= S0;
    end else begin
      current_state <= next_state;
    end
  end

  // State transition logic
  always_comb begin
    next_state = current_state; // Default: stay in the current state

    case (current_state)
      S0: begin
        if (data == 1) begin
          next_state = S1;
        end else begin
          next_state = S0;
        end
      end
      S1: begin
        if (data == 1) begin
          next_state = S2;
        end else begin
          next_state = S0;
        end
      end
      S2: begin
        if (data == 0) begin
          next_state = S3;
        end else begin
          next_state = S1;
        end
      end
      S3: begin
        if (data == 1) begin
          next_state = S4;
        end else begin
          next_state = S0;
        end
      end
      S4: begin
        next_state = S4; // Stay in S4 once the sequence is found
      end
      default: begin
        next_state = S0; // Should not happen, but handle it
      end
    endcase
  end

  // Output logic
  assign start_shifting = (current_state == S4);

endmodule
