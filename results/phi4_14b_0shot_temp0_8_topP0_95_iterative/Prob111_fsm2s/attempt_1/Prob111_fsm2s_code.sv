
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

  // Internal register to hold the current state
  state_t current_state, next_state;

  // Synchronous process for state transition and output generation
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset to OFF state on active-high reset
      current_state <= OFF;
    end else begin
      // State transitions occur at clock edges
      current_state <= next_state;
    end
  end

  // Combinational logic for determining the next state
  always @(*) begin
    case (current_state)
      OFF: begin
        if (j) begin
          next_state = ON;   // Transition to ON on j=1
        end else begin
          next_state = OFF;  // Remain in OFF on j=0
        end
      end

      ON: begin
        if (k) begin
          next_state = OFF;  // Transition to OFF on k=1
        end else begin
          next_state = ON;   // Remain in ON on k=0
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
