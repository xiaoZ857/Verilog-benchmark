
module TopModule (
  input clk,
  input in,
  input reset,
  output reg [7:0] out_byte,
  output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,   // Waiting for start bit (idle state)
        START_BIT = 3'b001, // Detected start bit
        DATA_BITS = 3'b010, // Capturing data bits
        STOP_BIT = 3'b011, // Checking stop bit
        WAIT_STOP_BIT = 3'b100 // Wait if stop bit is incorrect
    } state_t;

    state_t current_state, next_state;
    
    reg [2:0] bit_count; // Counter for the 8 data bits

begin
    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state and output logic
    always_comb begin
        done = 1'b0; // Default to not done
        next_state = current_state; // Default to staying in the same state
        
        case (current_state)
            IDLE: begin
                if (!in) begin
                    next_state = START_BIT;
                end
            end
            
            START_BIT: begin
                if (in) begin // Verify start bit is 0 and transition to DATA_BITS
                    next_state = DATA_BITS;
                    bit_count = 3'b000; // Reset counter for data bits
                end else begin
                    next_state = IDLE; // Invalid, go back to IDLE
                end
            end
            
            DATA_BITS: begin
                if (bit_count < 8) begin
                    out_byte[7 - bit_count] <= in; // Capture LSB first
                    bit_count = bit_count + 1;
                end else begin
                    next_state = STOP_BIT;
                end
            end
            
            STOP_BIT: begin
                if (in) begin
                    done = 1'b1; // Valid stop bit, set done to indicate byte received
                    next_state = IDLE; // Go back to IDLE for next byte
                end else begin
                    next_state = WAIT_STOP_BIT;
                end
            end
            
            WAIT_STOP_BIT: begin
                if (in) begin
                    next_state = IDLE; // Correct stop bit found, go back to IDLE
                end
                // Stay in WAIT_STOP_BIT until a valid stop bit is detected
            end

        endcase
    end
endmodule

// VERILOG-EVAL: errant inclusion of module definition
