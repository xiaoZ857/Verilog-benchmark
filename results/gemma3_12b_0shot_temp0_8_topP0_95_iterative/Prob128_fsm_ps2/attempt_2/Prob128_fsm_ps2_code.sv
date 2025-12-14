
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

  // Internal registers
  reg [7:0] received_byte;
  reg [1:0] byte_count;

  // Output register
  reg done;

  // State register update logic (synchronous)
  always_ff @(posedge clk) begin
    if (reset) begin
      current_state <= IDLE;
      done <= 1'b0;
    end else begin
      current_state <= next_state;
      done <= (next_state == IDLE && current_state == BYTE3); //done goes high when moving from BYTE3 to IDLE
    end
  end

  // Next state logic
  always_comb begin
    next_state = current_state;

    case (current_state)
      IDLE: begin
        if (in[3]) begin
          next_state = BYTE1;
          received_byte = in;
          byte_count = 2'b00;
        end else begin
          next_state = IDLE;
        end
      end

      BYTE1: begin
        if (byte_count == 2'b00) begin
          received_byte = in;
          byte_count = 2'b01;
          next_state = BYTE2;
        end else begin
          next_state = BYTE1; // Stay in BYTE1 until we receive the second byte.
        end
      end

      BYTE2: begin
        if (byte_count == 2'b01) begin
          received_byte = in;
          byte_count = 2'b10;
          next_state = BYTE3;
        end else begin
          next_state = BYTE2; // Stay in BYTE2 until we receive the third byte.
        end
      end

      BYTE3: begin
        if (byte_count == 2'b10) begin
          received_byte = in;
          byte_count = 2'b11;
          next_state = IDLE;
        end else begin
          next_state = BYTE3; // Stay in BYTE3 until we receive the third byte.
        end
      end

      default: begin
        next_state = IDLE;
      end
    endcase
  end
endmodule
