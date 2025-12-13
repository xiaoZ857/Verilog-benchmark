
// Define time scale at the beginning of the file
`timescale 1ns/1ps

module TopModule (
  input clk,
  input in,
  input areset,
  output out
);

  // State definition
  typedef enum {
    A = 0,
    B = 1,
    C = 2,
    D = 3
  ) state_t;

  // Current and next state registers
  state_t current_state, next_state;
  
  // Output signal
  wire out;

  // State transition and output logic
  always_ff @ (posedge clk) begin
    if (areset) begin
      current_state <= A;
    end else begin
      case (current_state)
        A: 
          if (in == 0) next_state = A;
          else          next_state = B;
          out = 0;
        B:
          if (in == 0) next_state = C;
          else          next_state = B;
          out = 0;
        C:
          if (in == 0) next_state = A;
          else          next_state = D;
          out = 0;
        D:
          if (in == 0) next_state = C;
          else          next_state = B;
          out = 1;
        default:
          next_state = A;  // Default to reset state
          out = 0;
      endcase
    end
  end

  // Register for current state
  always_comb begin
    current_state = next_state;
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
