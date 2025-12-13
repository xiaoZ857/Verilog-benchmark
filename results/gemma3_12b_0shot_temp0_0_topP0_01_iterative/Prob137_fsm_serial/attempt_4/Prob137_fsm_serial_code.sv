
module TopModule (
  input clk,
  input in,
  input reset,
  output done
);
  // State definition
  typedef enum logic [2:0] {
    IDLE,
    START_DETECTED,
    RECEIVING_DATA,
    STOP_DETECTED,
    ERROR_STATE
  } state_t;

  state_t current_state, next_state;

  // Internal signals
  logic [2:0] bit_count;
  logic start_bit_detected;
  logic stop_bit_detected;
  logic error_detected;
  logic done;

  // Registering the state
  always_ff @(posedge clk) begin
    if (reset) begin
      current_state <= IDLE;
      start_bit_detected <= 1'b0;
      stop_bit_detected <= 1'b0;
      error_detected <= 1'b0;
      bit_count <= 3'b000;
      done <= 1'b0;
    end else begin
      current_state <= next_state;
      if (next_state != current_state) begin
        if (next_state == START_DETECTED) begin
          start_bit_detected <= 1'b1;
        end else if (next_state == IDLE) begin
          start_bit_detected <= 1'b0;
        end
        if (next_state == STOP_DETECTED) begin
          stop_bit_detected <= 1'b1;
        end else if (next_state == IDLE) begin
          stop_bit_detected <= 1'b0;
        end
      end
    end
  end

  // Next state logic
  always_comb begin
    next_state = current_state;
    done = 1'b0;

    case (current_state)
      IDLE: begin
        if (in == 0) begin
          next_state = START_DETECTED;
        end
      end
      START_DETECTED: begin
        next_state = RECEIVING_DATA;
        bit_count = 3'b001;
      end
      RECEIVING_DATA: begin
        if (bit_count == 3'b001) begin
          // Receive first data bit
        end else if (bit_count == 3'b010) begin
          // Receive second data bit
        end else if (bit_count == 3'b011) begin
          // Receive third data bit
        end else if (bit_count == 3'b100) begin
          // Receive fourth data bit
        end else if (bit_count == 3'b101) begin
          // Receive fifth data bit
        end else if (bit_count == 3'b110) begin
          // Receive sixth data bit
        end else if (bit_count == 3'b111) begin
          // Receive seventh data bit
        end else if (bit_count == 3'b000) begin
          // Receive eighth data bit
          next_state = STOP_DETECTED;
          bit_count = 3'b001;
        end else begin
          next_state = IDLE;
          bit_count = 3'b000;
        end
      end
      STOP_DETECTED: begin
        if (in == 1) begin
          next_state = IDLE;
          done = 1'b1;
          bit_count = 3'b000;
        end else begin
          next_state = ERROR_STATE;
          bit_count = 3'b000;
        end
      end
      ERROR_STATE: begin
        if (in == 1) begin
          next_state = IDLE;
          bit_count = 3'b000;
        end else begin
          next_state = ERROR_STATE;
        end
      end
    endcase
  end

endmodule
