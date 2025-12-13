
module TopModule (
  input clk,
  input aresetn, // Active low asynchronous reset
  input x,
  output reg z
);

  // State encoding
  typedef enum logic [1:0] {
    S0 = 2'b00, // Initial state, waiting for '1'
    S1 = 2'b01, // Detected '1', waiting for '0'
    S2 = 2'b10  // Detected '10', waiting for '1' to complete "101"
  } state_t;

  state_t current_state, next_state;

  always_ff @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
      current_state <= S0;
    end else begin
      current_state <= next_state;
    end
  end

  always_comb begin
    // Default assignments
    z = 1'b0; // Default output is low
    case (current_state)
      S0: begin
        if (x == 1'b1) begin
          next_state = S1;
        end else begin
          next_state = S0;
        end
      end

      S1: begin
        if (x == 1'b0) begin
          next_state = S2;
        end else begin
          next_state = S1; // Stay in S1 if another '1' is detected
        end
      end

      S2: begin
        if (x == 1'b1) begin
          next_state = S0;
          z = 1'b1; // Sequence "101" detected, assert output
        end else begin
          next_state = S0; // Reset to initial state on '0'
        end
      end

      default: begin
        next_state = S0;
      end
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
