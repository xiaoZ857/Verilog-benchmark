
module TopModule (
  input clk,
  input in,
  input reset,
  output reg done
);

  typedef enum logic [2:0] {
    IDLE = 3'b000,   // Waiting for a start bit (0)
    START_BIT = 3'b001, // Checking the start bit
    DATA_BITS = 3'b010, // Collecting data bits
    STOP_BIT = 3'b011,  // Verifying stop bit
    DONE = 3'b100     // Byte received correctly
  } state_t;

  state_t current_state, next_state;
  reg [7:0] data;   // Register to store the collected data bits
  integer bit_counter; // Counter for data bits

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= IDLE;
      done <= 1'b0;
      data <= 8'd0;
      bit_counter <= 0;
    end else begin
      current_state <= next_state;

      case(current_state)
        START_BIT: begin
          // Reset data and counter when entering a new byte
          if (bit_counter == 0) begin
            data <= 8'd0;
          end
          bit_counter <= bit_counter + 1;
        end
        
        DATA_BITS: begin
          // Shift in the incoming bits as they arrive LSB first
          data <= {data[6:0], in};
          bit_counter <= bit_counter + 1;
        end
        
        DONE: begin
          done <= 1'b1; // Indicate that a byte was correctly received
        end

        default: begin
          done <= 1'b0;
        end
      endcase
    end
  end

  always_comb begin
    next_state = current_state;

    case(current_state)
      IDLE: begin
        if (in == 1'b0) begin // Start bit detected
          next_state = START_BIT;
        end
      end
      
      START_BIT: begin
        if (bit_counter == 1) begin
          // Confirm the start bit was a 0 and transition to data bits state
          next_state = DATA_BITS;
          bit_counter <= 0; // Reset counter for data bits
        end else if (in != 1'b0) begin
          // Invalid start bit, go back to IDLE
          next_state = IDLE;
        end
      end
      
      DATA_BITS: begin
        if (bit_counter == 8) begin
          // All data bits received, move to stop bit state
          next_state = STOP_BIT;
        end else if (in != 1'b0 && in != 1'b1) begin
          // Invalid signal detected, return to IDLE and wait for next valid start
          next_state = IDLE;
        end
      end

      STOP_BIT: begin
        if (in == 1'b1) begin 
          // Correct stop bit received, complete the byte reception
          next_state = DONE;
        end else begin
          // Invalid stop bit detected, return to IDLE and wait for start of next valid byte
          next_state = IDLE;
        end
      end

      DONE: begin
        if (in == 1'b1) begin
          // Ensure we remain in DONE state until idle or reset
          next_state = IDLE; 
        end
      end
      
      default: begin
        next_state = IDLE; // Default safety case
      end

    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
