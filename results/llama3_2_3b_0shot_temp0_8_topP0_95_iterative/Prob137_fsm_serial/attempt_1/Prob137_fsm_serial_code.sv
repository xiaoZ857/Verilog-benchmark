
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
  DATA BIT,   // Waiting for data bits
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
        end else begin  // If not start bit, remain in START_BIT
          fsm_state <= START_BIT;
        end
      DATA_BIT:
        if (~in) begin  // Data bit transition occurs
          fsm_data_bits[7] = in;
        end else begin  // Receive next data bit
          fsm_data_bits[0] = in;  // Least significant bit first
          if (fsm_state == DATA_BIT) begin  // All 8 data bits received
            fsm_state <= STOP_BIT;
          end else begin  // Remain in START_BIT until all 8 data bits are received
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
      default:
        // Ignore other states for simplicity
    endcase;
  end
end

// Outputs
assign done = (fsm_state == STOP_BIT);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
