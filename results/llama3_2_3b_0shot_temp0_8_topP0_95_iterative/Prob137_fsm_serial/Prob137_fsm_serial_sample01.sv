
module TopModule (
  input clk,
  input in,
  input reset,
  output done
);

// Define the states of the FSM
typedef enum reg [1:0] {
  IDLE,  // Idle state
  START_BIT,  // Waiting for start bit
  DATA_BIT,   // Waiting for data bits
  STOP_BIT   // Waiting for stop bit
} fsm_state_t;

// Current state of the FSM
reg fsm_state_t fsm_state = IDLE;
reg [0:7] fsm_data_bits = {1'b0};  // To store received data bits

always @(posedge clk) begin
  if (reset) begin
    fsm_state <= IDLE;
    fsm_data_bits <= {1'b0};
  end else begin
    case (fsm_state)
      IDLE:
        if (~in && in) begin  // If idle transition occurs, set state to START_BIT
          fsm_state <= START_BIT;
        end
      START_BIT:
        if (in == 0) begin  // Start bit found, wait for data bits
          fsm_state <= DATA_BIT;
          fsm_data_bits[7] = in;  // Store start bit in least significant position
        end else begin  // If not start bit, remain in START_BIT
          fsm_state <= START_BIT;
        end
      DATA_BIT:
        if (~in) begin  // Data bit transition occurs
          fsm_data_bits[0] = in;  // Receive next data bit, keep most significant bits unchanged
        end else begin  // Receive next data bit
          fsm_data_bits[7] = in;  // Store received data bit in least significant position
          if (fsm_state == DATA_BIT && fsm_data_bits[7] == 1'b0) begin  // Check stop bit is correct
            fsm_state <= STOP_BIT;
          end else begin  // Wait for stop bit, continue with START_BIT state
            fsm_state <= START_BIT;
          end
        end
      STOP_BIT:
        if (~in && in) begin  // Stop bit transition occurs and matches expected value (1)
          fsm_state <= IDLE;  // Successful byte received, reset FSM
          done <= 1'b1;
        end else begin  // If not stop bit, remain in STOP_BIT
          fsm_state <= STOP_BIT;
        end
    endcase;
  end
end

// Outputs
assign done = (fsm_state == STOP_BIT);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
