
module TopModule (
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack
);

  typedef enum {
    SEARCH = 0,
    DETECTED,
    SHIFT,
    WAIT,
    DONE,
    ACKNOWLEDGE
  ) state_t;

  state_t state, next_state;

  always_ff @ (posedge clk) begin
    if (reset) begin
      state <= SEARCH;
    end else begin
      state <= next_state;
    end
  end

  always_comb begin
    shift_ena = 0;
    counting = 0;
    done = 0;

    case (state)
      SEARCH: begin
        // Look for pattern 1101
        if (data == 1 && prev_data == 1 && prev_prev_data == 0) begin
          next_state = DETECTED;
        end else begin
          next_state = SEARCH;
        end
      end

      DETECTED: begin
        shift_ena = 1;
        next_state = SHIFT;
      end

      SHIFT: begin
        shift_ena = 1;
        if (done_counting == 1) begin
          next_state = WAIT;
        end else begin
          next_state = SHIFT;
        end
      end

      WAIT: begin
        counting = 1;
        if (ack == 1) begin
          next_state = ACKNOWLEDGE;
        end else begin
          next_state = WAIT;
        end
      end

      DONE: begin
        done = 1;
        if (ack == 1) begin
          next_state = SEARCH;
        end else begin
          next_state = DONE;
        end
      end

      ACKNOWLEDGE: begin
        shift_ena = 0;
        counting = 0;
        done = 0;
        if (data == 1 && prev_data == 1 && prev_prev_data == 0) begin
          next_state = DETECTED;
        end else begin
          next_state = ACKNOWLEDGE;
        end
      end
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
