
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
  // State definition
  typedef enum logic [1:0] {
    IDLE,
    BYTE1,
    BYTE2,
    BYTE3
  } state_t;

  state_t current_state, next_state;

  // Internal signals
  logic byte_valid;
  logic [7:0] received_byte;

  always_ff @(posedge clk) begin
    if (reset) begin
      current_state <= IDLE;
      done <= 0;
    end else begin
      current_state <= next_state;
    end
  end

  always_comb begin
    next_state = current_state;
    byte_valid = 0; // Default: byte is not valid
    done = 0; // Default: done is not asserted

    case (current_state)
      IDLE: begin
        if (in[3]) begin
          next_state = BYTE1;
          byte_valid = 1;
          received_byte = in;
        end
      end

      BYTE1: begin
        if (byte_valid) begin
          next_state = BYTE2;
          byte_valid = 0;
        end else begin
          next_state = BYTE1;
        end
      end

      BYTE2: begin
        if (byte_valid) begin
          next_state = BYTE3;
          byte_valid = 0;
        end else begin
          next_state = BYTE2;
        end
      end

      BYTE3: begin
        next_state = IDLE;
        done = 1;
        byte_valid = 0;
      end

      default: begin
        next_state = IDLE;
      end
    endcase
  end

  // Input data latch
  always_ff @(posedge clk) begin
    if (reset) begin
      received_byte <= 0;
    end else if (byte_valid) begin
      received_byte <= in;
    end
  end

endmodule
