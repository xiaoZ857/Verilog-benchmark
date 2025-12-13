
module TopModule (
  input clk,
  input in,
  input reset,
  output reg done
);

  // State encoding
  typedef enum logic [2:0] {
    IDLE = 3'b000,
    START_BIT = 3'b001,
    DATA_BITS = 3'b010,
    STOP_BIT = 3'b011,
    ERROR_WAIT_STOP = 3'b100
  } state_t;

  // State register
  reg [2:0] current_state, next_state;
  
  // Data bit counter
  reg [2:0] bit_counter; // 3 bits to count from 0 to 7

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= IDLE;
      done <= 1'b0;
      bit_counter <= 3'b000;
    end else begin
      current_state <= next_state;
      
      // Handle the 'done' signal only in specific states
      case (current_state)
        STOP_BIT: done <= 1'b1; // Indicate successful byte reception
        default: done <= 1'b0;
      endcase

      if (current_state == DATA_BITS) begin
        bit_counter <= bit_counter + 1'b1;
      end else begin
        bit_counter <= 3'b000;
      end
    end
  end

  always_comb begin
    next_state = current_state; // Default to staying in the same state
    
    case (current_state)
      IDLE: begin
        if (!in) begin
          next_state = START_BIT;
        end
      end
      
      START_BIT: begin
        if (in) begin
          next_state = DATA_BITS;
        end else begin
          // Stay in START_BIT if still 0, expecting transition to 1
        end
      end

      DATA_BITS: begin
        if (bit_counter == 3'b111) begin
          next_state = STOP_BIT;
        end
      end
      
      STOP_BIT: begin
        if (!in) begin
          // Error detected, wait for a stop bit
          next_state = ERROR_WAIT_STOP;
        end else begin
          // Correct stop bit received
          next_state = IDLE;
        end
      end

      ERROR_WAIT_STOP: begin
        if (in) begin
          // Found the expected stop bit after error
          next_state = IDLE;
        end
      end
      
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
