
module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);
  // State definition
  typedef enum logic [2:0] {
    IDLE,
    START_DETECTED,
    RECEIVING_DATA,
    STOP_DETECTED
  } state_t;

  state_t current_state, next_state;

  // Internal signals
  reg [7:0] received_data;
  reg [2:0] data_bit_count;
  reg stop_bit_expected;
  reg done;

  // State register update
  always_ff @(posedge clk) begin
    if (reset) begin
      current_state <= IDLE;
      done <= 0;
      received_data <= 0;
      data_bit_count <= 0;
      stop_bit_expected <= 0;
    end else begin
      current_state <= next_state;
      done <= 0;
      stop_bit_expected <= 0;
    end
  end

  // Next state logic
  always_comb begin
    next_state = current_state;
    case (current_state)
      IDLE: begin
        if (in == 0) begin
          next_state = START_DETECTED;
        end
      end
      START_DETECTED: begin
        next_state = RECEIVING_DATA;
        data_bit_count = 0;
      end
      RECEIVING_DATA: begin
        if (data_bit_count == 7) begin
          next_state = STOP_DETECTED;
        end else begin
          next_state = RECEIVING_DATA;
        end
      end
      STOP_DETECTED: begin
        if (in == 1) begin
          next_state = IDLE;
          done = 1;
          stop_bit_expected = 1;
        end else begin
          next_state = STOP_DETECTED;
          stop_bit_expected = 0;
        end
      end
    endcase
  end

  // Data capture and output
  always_ff @(posedge clk) begin
    if (reset) begin
      received_data <= 0;
    end else begin
      if (current_state == START_DETECTED) begin
        // Start receiving data
        received_data <= 0;
      end else if (current_state == RECEIVING_DATA) begin
        // Shift in the data bit
        received_data <= {received_data[6:0], in};
        data_bit_count <= data_bit_count + 1;
      end
    end
  end

  assign out_byte = received_data;

endmodule
