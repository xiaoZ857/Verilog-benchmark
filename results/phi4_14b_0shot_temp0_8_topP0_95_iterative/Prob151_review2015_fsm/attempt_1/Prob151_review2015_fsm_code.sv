
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
    end else begin
      current_state <= next_state;
    end
  end

  always_comb begin
    // Default outputs
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;

    case (current_state)
      IDLE: begin
        if (pattern == 4'b1101) begin
          next_state = SHIFT_1;
        end else begin
          // Shift in new data bit and update pattern
          pattern = {pattern[2:0], data};
          next_state = IDLE;
        end
      end

      SHIFT_1: begin
        shift_ena = 1'b1; // Start shifting
        next_state = SHIFT_2;
      end
      
      SHIFT_2: begin
        shift_ena = 1'b1;
        next_state = SHIFT_3;
      end

      SHIFT_3: begin
        shift_ena = 1'b1;
        next_state = SHIFT_4;
      end

      SHIFT_4: begin
        shift_ena = 1'b1; // Shift last bit
        shift_ena = 1'b0; // Disable shifting after this cycle
        counting = 1'b1; // Start the count
        next_state = WAIT_DONE_COUNTING;
      end

      WAIT_DONE_COUNTING: begin
        if (done_counting) begin
          next_state = NOTIFY_USER;
        end else begin
          next_state = WAIT_DONE_COUNTING;
        end
      end

      NOTIFY_USER: begin
        done = 1'b1; // Notify user that countdown is done
        if (ack) begin
          next_state = IDLE; // Acknowledged, reset to start looking for pattern again
        end else begin
          next_state = NOTIFY_USER;
        end
      end

      default: next_state = IDLE; // Safety net
    endcase
  end
  
endmodule

// VERILOG-EVAL: errant inclusion of module definition
