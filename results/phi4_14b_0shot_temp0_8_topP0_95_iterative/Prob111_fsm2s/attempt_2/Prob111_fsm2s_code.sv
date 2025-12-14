
module TopModule (
  input wire clk,
  input wire j,
  input wire k,
  input wire reset,
  output reg out
);

  // State encoding
  typedef enum logic [1:0] {
    OFF = 2'b00,
    ON  = 2'b01
  } state_t;

  // Internal registers to hold the current and next states
  state_t current_state, next_state;

  // Synchronous process for state transition including reset
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset both current and next state synchronously on active-high reset
      current_state <= OFF;
      next_state <= OFF;  // This ensures the system is stable immediately after reset
    end else begin
      current_state <= next_state;
    end
  end

  // Combinational logic for determining the next state based on inputs and current state
  always @(*) begin
    case (current_state)
      OFF: begin
        if (j) begin
          next_state = ON;   // Transition to ON if j=1
        end else begin
          next_state = OFF;  // Remain in OFF if j=0
        end
      end

      ON: begin
        if (k) begin
          next_state = OFF;  // Transition to OFF if k=1
        end else begin
          next_state = ON;   // Remain in ON if k=0
        end
      end

      default: begin
        next_state = OFF;    // Default to OFF for any undefined state
      end
    endcase
  end

  // Output logic based on the current state (Moore machine)
  always @(*) begin
    case (current_state)
      OFF: out = 0;
      ON:  out = 1;
      default: out = 0;     // Default output to 0 in undefined states
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
