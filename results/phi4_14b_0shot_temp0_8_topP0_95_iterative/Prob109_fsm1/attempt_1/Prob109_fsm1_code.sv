
module TopModule (
  input wire clk,
  input wire in,
  input wire areset,
  output reg out
);

  // State encoding
  typedef enum logic [1:0] {
    STATE_A = 2'b00,  // A
    STATE_B = 2'b01   // B (Reset state)
  } state_t;

  state_t current_state, next_state;

  // Moore output logic based on the current state
  always_comb begin
    out = 0;  // Default output
    case (current_state)
      STATE_A: out = 1;
      STATE_B: out = 1;
      default: out = 0;  // Safe default
    endcase
  end

  // Next state logic and asynchronous reset
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= STATE_B;  // Asynchronous reset to state B
    end else begin
      current_state <= next_state;
    end
  end

  // Determine the next state based on current state and input
  always_comb begin
    case (current_state)
      STATE_A: begin
        if (in == 0) next_state = STATE_B;
        else         next_state = STATE_A;
      end
      STATE_B: begin
        if (in == 0) next_state = STATE_B;
        else         next_state = STATE_A;
      end
      default:   next_state = STATE_B;  // Default to B on undefined state
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
