
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

  // Declare the current and next state registers
  state_t current_state, next_state;

  // Sequential logic for state transition
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= OFF; // Reset to OFF state
      out <= 0;             // Ensure output is 0 during reset
    end else begin
      current_state <= next_state;
    end
  end

  // Combinational logic to determine the next state and output
  always_comb begin
    case (current_state)
      OFF: begin
        out = 0; // Output is 0 in OFF state
        if (j) begin
          next_state = ON;
        end else begin
          next_state = OFF;
        end
      end

      ON: begin
        out = 1; // Output is 1 in ON state
        if (k) begin
          next_state = OFF;
        end else begin
          next_state = ON;
        end
      end

      default: begin
        out = 0;
        next_state = OFF;
      end
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
