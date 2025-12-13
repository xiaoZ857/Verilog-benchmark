
module TopModule (
  input clk,
  input in,
  input reset,
  output done
);

  // Define states
  typedef enum {
    IDLE,
    START,
    DATA,
    STOP,
    ERROR
  ) state_type;

  state_type state, next_state;
  
  // Data register to store the received byte
  reg [7:0] data_reg;
  
  // Count for data bits
  reg [2:0] data_count;
  
  // Control signals
  reg done_reg;

  // Main state machine logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      data_reg <= 0;
      data_count <= 0;
      done_reg <= 0;
    end else begin
      state <= next_state;
      case (state)
        IDLE: begin
          if (in == 0) begin
            next_state <= START;
            data_reg <= 0;
            data_count <= 7; // We need to receive 8 bits
          end else begin
            next_state <= IDLE;
          end
        end
        
        START: begin
          next_state <= DATA;
          data_count <= 7;
        end
        
        DATA: begin
          if (in) begin
            data_reg = (data_reg << 1) | in; // Shift left and add new bit
            data_count--;
            
            if (data_count == 0) begin
              next_state <= STOP;
            end else begin
              next_state <= DATA;
            end
          end else begin
            next_state <= ERROR;
          end
        end
        
        STOP: begin
          if (in == 1) begin
            done_reg <= 1;
            next_state <= IDLE;
          end else begin
            next_state <= ERROR;
          end
        end
        
        ERROR: begin
          if (in == 1) begin // Wait for correct stop bit
            done_reg <= 0;
            next_state <= IDLE;
          end else begin
            next_state <= ERROR;
          end
        end
      endcase
    end
  end

  // Output control
  always @(posedge clk) begin
    if (state == STOP && in == 1) begin
      done <= 1;
    end else begin
      done <= done_reg;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
