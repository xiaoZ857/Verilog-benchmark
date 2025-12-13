
// Implement the Verilog module based on the following description. Assume that signals are positive clock/clk triggered unless otherwise stated.

// Moore state machine with two states, two inputs, and one output.
// Reset is an active-high synchronous reset to state OFF.

// State transitions:
//  OFF (out=0) --j=0--> OFF
//  OFF (out=0) --j=1--> ON
//  ON  (out=1) --k=0--> ON
//  ON  (out=1) --k=1--> OFF

module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

  // Define states
  typedef enum {
    OFF,
    ON
  } state_t;

  state_t current_state, next_state;
  
  // Output is directly determined by the current state (Moore machine)
  assign out = (current_state == ON) ? 1 : 0;

  always @(posedge clk or reset) begin
    if (reset) begin
      current_state <= OFF;
    end else begin
      case (current_state)
        OFF: begin
          if (j) begin
            next_state = ON;
          end else begin
            next_state = OFF;
          end
        end
        ON: begin
          if (k) begin
            next_state = OFF;
          end else begin
            next_state = ON;
          end
      endcase
      current_state <= next_state;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
