
// Define timescale outside module
`timescale 1ns / 1ps

module TopModule (
  input clk,
  input reset,
  input start_shift,
  output shift_ena
);

  // State definitions
  typedef enum {
    S0 = 0,          // Initial state
    S1 = 1,          // Count 1 cycle
    S2 = 2,          // Count 2 cycles
    S3 = 3,          // Count 3 cycles
    S4 = 4           // Count 4 cycles (final state)
  ) state_t;

  reg [2:0] current_state;  // 3-bit register for state storage
  reg shift_ena;

  // State transition and output logic
  always @ (posedge clk) begin
    if (reset == 1) begin         // Active high reset
      current_state <= S0;
      shift_ena <= 0;
    end else begin
      case (current_state)
        S0: begin
          if (start_shift) begin  // Transition to S1 when start condition is met
            current_state <= S1;
            shift_ena <= 1;
          end else begin
            current_state <= S0;
            shift_ena <= 0;
          end
        end
        
        S1: begin
          current_state <= S2;
          shift_ena <= 1;
        end

        S2: begin
          current_state <= S3;
          shift_ena <= 1;
        end

        S3: begin
          current_state <= S4;
          shift_ena <= 1;
        end

        default: begin            // Return to initial state after counting
          current_state <= S0;
          shift_ena <= 0;
        end
      endcase
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
