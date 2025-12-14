
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

  // Internal registers
  reg [7:0] received_byte;
  reg [2:0] bit_count;
  reg stop_bit_expected;

  // Outputs
  assign done = (current_state == STOP_DETECTED);
  assign out_byte = (current_state == STOP_DETECTED) ? received_byte : 0;

  // State register update
  always_ff @(posedge clk) begin
    if (reset) begin
      current_state <= IDLE;
      bit_count <= 0;
      stop_bit_expected <= 0;
    end else begin
      current_state <= next_state;
      if (current_state == RECEIVING_DATA) begin
          bit_count <= bit_count + 1;
      end
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
        bit_count = 0;
        stop_bit_expected = 0;
      end
      RECEIVING_DATA: begin
        if (bit_count == 7) begin
          next_state = STOP_DETECTED;
          stop_bit_expected = 1;
        end else if (in != stop_bit_expected) begin
          next_state = IDLE;
          stop_bit_expected = 0;
        end
      end
      STOP_DETECTED: begin
        next_state = IDLE;
      end
    endcase
  end

  // Data capture logic
  always_ff @(posedge clk) begin
    if (reset) begin
      received_byte <= 0;
    end else begin
      if (current_state == START_DETECTED) begin
        // Start receiving data.
      end else if (current_state == RECEIVING_DATA) begin
        received_byte <= received_byte | (in << bit_count);
      end
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
