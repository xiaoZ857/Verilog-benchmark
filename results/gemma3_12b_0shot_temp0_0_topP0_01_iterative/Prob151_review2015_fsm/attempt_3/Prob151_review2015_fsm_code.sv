
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
  // Define states
  typedef enum logic [2:0] {
    IDLE,
    SHIFT,
    COUNTING,
    DONE
  } state_t;

  reg state, next_state;

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
    next_state = state; // Default: stay in the current state

    case (state)
      IDLE: begin
        if (data == 1) begin
          next_state = IDLE;
        end else begin
          next_state = IDLE;
        end
      end

      SHIFT: begin
        if (data == 1) begin
          next_state = SHIFT;
        end else begin
          next_state = SHIFT;
        end
      end

      COUNTING: begin
        next_state = COUNTING;
      end

      DONE: begin
        next_state = DONE;
      end

      default: begin
        next_state = IDLE;
      end
    endcase
  end

  always_ff @(posedge clk) begin
    if (reset) begin
      shift_ena <= 0;
      counting <= 0;
      done <= 0;
    end else begin
      case (state)
        IDLE: begin
          shift_ena <= 0;
          counting <= 0;
          done <= 0;
        end
        SHIFT: begin
          shift_ena <= 1;
          counting <= 0;
          done <= 0;
        end
        COUNTING: begin
          shift_ena <= 0;
          counting <= 1;
          done <= 0;
        end
        DONE: begin
          shift_ena <= 0;
          counting <= 0;
          done <= 1;
        end
      endcase
    end
  end

  always_ff @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      case (state)
        IDLE: begin
          if (data == 1) begin
            next_state <= IDLE;
          end else if (data == 0) begin
            next_state <= IDLE;
          end
        end
        SHIFT: begin
          if (data == 1) begin
            next_state <= SHIFT;
          end else if (data == 0) begin
            next_state <= SHIFT;
          end
        end
        COUNTING: begin
          next_state <= COUNTING;
        end
        DONE: begin
          next_state <= DONE;
        end
      endcase
    end
  end

endmodule
