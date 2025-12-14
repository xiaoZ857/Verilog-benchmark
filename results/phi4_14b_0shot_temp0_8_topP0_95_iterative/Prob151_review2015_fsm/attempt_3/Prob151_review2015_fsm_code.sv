
module TopModule (
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack
);

  // Define the states for the FSM
  typedef enum logic [2:0] {
    IDLE = 3'b000,      // Looking for start pattern "1101"
    SHIFT_1 = 3'b001,   // First bit of shifting after detecting pattern
    SHIFT_2 = 3'b010,   // Second bit of shifting
    SHIFT_3 = 3'b011,   // Third bit of shifting
    SHIFT_4 = 3'b100,   // Fourth bit of shifting
    WAIT_DONE_COUNTING = 3'b101, // Waiting for counters to finish counting
    NOTIFY_USER = 3'b110 // Notify user that countdown is done
  } state_t;

  // Registers for the current and next states
  state_t current_state, next_state;
  
  reg [3:0] pattern; // To store incoming bits and detect "1101"

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= IDLE;
      shift_ena <= 1'b0;
      counting <= 1'b0;
      done <= 1'b0;
      pattern <= 4'b0000; // Ensure pattern is initialized on reset
    end else begin
      current_state <= next_state;

      case (current_state)
        SHIFT_1: shift_ena <= 1'b1;
        SHIFT_2: shift_ena <= 1'b1;
        SHIFT_3: shift_ena <= 1'b1;
        SHIFT_4: begin 
          shift_ena <= 1'b1; // Shift last bit
          counting <= 1'b1; // Start the count
        end
        default: begin
          shift_ena <= 1'b0;
          counting <= 1'b0;
        end
      endcase

      if (current_state == SHIFT_4) begin
        shift_ena <= 1'b0; // Disable shifting after this cycle
      end

      done <= (current_state == NOTIFY_USER);
    end
  end

  always_comb begin
    // Default outputs and next state logic
    next_state = current_state;
    
    case (current_state)
      IDLE: begin
        pattern = {pattern[2:0], data}; // Shift in new data bit and update pattern
        if (pattern == 4'b1101) begin
          next_state = SHIFT_1;
        end
      end

      SHIFT_1: begin
        next_state = SHIFT_2;
      end
      
      SHIFT_2: begin
        next_state = SHIFT_3;
      end

      SHIFT_3: begin
        next_state = SHIFT_4;
      end

      SHIFT_4: begin
        // No action needed in this state as handled above
      end

      WAIT_DONE_COUNTING: begin
        if (done_counting) begin
          next_state = NOTIFY_USER;
        end
      end

      NOTIFY_USER: begin
        if (ack) begin
          next_state = IDLE; // Acknowledged, reset to start looking for pattern again
        end
      end
      
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
