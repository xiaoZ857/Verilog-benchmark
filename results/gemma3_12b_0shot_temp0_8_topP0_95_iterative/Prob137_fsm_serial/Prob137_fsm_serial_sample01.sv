
module TopModule (
  input clk,
  input in,
  input reset,
  output done
);
  // Define states
  typedef enum logic [2:0] {
    IDLE,
    START_DETECTED,
    RECEIVING_DATA,
    STOP_DETECTED
  } state_t;

  reg state, next_state;

  // Counters
  reg [2:0] data_count;
  reg stop_bit_expected;

  // Output signal
  //reg done; // Remove this line, as it's already declared in the module interface

  // State register update
  always_ff @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end

  // Next state logic
  always_comb begin
    next_state = state;
    done = 0; // Default: not done

    case (state)
      IDLE: begin
        if (in == 0) begin
          next_state = START_DETECTED;
        end
      end

      START_DETECTED: begin
        next_state = RECEIVING_DATA;
        data_count = 0;
        stop_bit_expected = 0;
      end

      RECEIVING_DATA: begin
        if (data_count == 7) begin
          next_state = STOP_DETECTED;
        end else begin
          next_state = RECEIVING_DATA;
        end
        if (data_count == 7) begin
          //data_count = 0;
        end
        else begin
          //data_count = data_count;
        end

        data_count = data_count + 1; // Increment data counter
      end

      STOP_DETECTED: begin
        if (in == 1) begin
          next_state = IDLE;
          done = 1;
        end else begin
          next_state = RECEIVING_DATA; // Wait for stop bit
        end
      end

      default: begin
        next_state = IDLE;
      end
    endcase
  end

endmodule
