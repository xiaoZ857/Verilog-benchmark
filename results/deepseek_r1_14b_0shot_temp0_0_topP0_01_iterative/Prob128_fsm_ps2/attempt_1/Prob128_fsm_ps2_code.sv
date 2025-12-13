
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  // State definition
  typedef enum {
    IDLE = 0,
    EXPECTING_SECOND_BYTE = 1,
    EXPECTING_THIRD_BYTE = 2
  } state_t;

  state_t state, next_state;
  
  // Additional signals
  reg message_received;  // To indicate when a message has started

  // FSM transition logic
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      message_received <= 0;
      done <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (in[3]) begin
            next_state <= EXPECTING_SECOND_BYTE;
            message_received <= 1;
            done <= 0;  // Reset done when starting a new message
          end else begin
            next_state <= IDLE;
          end
        end
        
        EXPECTING_SECOND_BYTE: begin
          next_state <= EXPECTING_THIRD_BYTE;
        end
        
        EXPECTING_THIRD_BYTE: begin
          // After receiving the third byte, set done and reset state
          next_state <= IDLE;
          done <= 1;
        end
      endcase
      
      state <= next_state;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
