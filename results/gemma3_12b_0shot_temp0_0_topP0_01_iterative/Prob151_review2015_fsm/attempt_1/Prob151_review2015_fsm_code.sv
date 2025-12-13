
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
          next_state = IDLE; // Stay in IDLE if first bit is 0
        end else begin
          next_state = IDLE; // Stay in IDLE if first bit is 0
        end
      end

      IDLE: begin
        if (data == 1) begin
          next_state = IDLE;
        end else if (data == 1) begin
          next_state = IDLE;
        end else if (data == 0) begin
          next_state = IDLE;
        end else if (data == 1) begin
          next_state = IDLE;
        end
      end

      IDLE: begin
        if (data == 1) begin
          next_state = IDLE;
        end else if (data == 1) begin
          next_state = IDLE;
        end else if (data == 0) begin
          next_state = IDLE;
        end else if (data == 1) begin
          next_state = IDLE;
        end
      end

      IDLE: begin
        if (data == 1) begin
          next_state = IDLE;
        end else if (data == 1) begin
          next_state = IDLE;
        end else if (data == 0) begin
          next_state = IDLE;
        end else if (data == 1) begin
          next_state = IDLE;
        end
      end

      IDLE: begin
        if (data == 1) begin
          next_state = IDLE;
        end else if (data == 1) begin
          next_state = IDLE;
        end else if (data == 0) begin
          next_state = IDLE;
        end else if (data == 1) begin
          next_state = IDLE;
        end
      end

      IDLE: begin
        if (data == 1) begin
          next_state = IDLE;
        end else if (data == 1) begin
          next_state = IDLE;
        end else if (data == 0) begin
          next_state = IDLE;
        end else if (data == 1) begin
          next_state = IDLE;
        end
      end

      IDLE: begin
        if (data == 1) begin
          next_state = IDLE;
        end else if (data == 1) begin
          next_state = IDLE;
        end else if (data == 0) begin
          next_state = IDLE;
        end else if (data == 1) begin
          next_state = IDLE;
        end
      end

      IDLE: begin
        if (data == 1) begin
          next_state = IDLE;
        end else if (data == 1) begin
          next_state = IDLE;
        end else if (data == 0) begin
          next_state = IDLE;
        end else if (data == 1) begin
          next_state = IDLE;
        end
      end

      IDLE: begin
        if (data == 1) begin
          next_state = IDLE;
        end else if (data == 1) begin
          next_state = IDLE;
        end else if (data == 0) begin
          next_state = IDLE;
        end else if (data == 1) begin
          next_state = IDLE;
        end
      end

      IDLE: begin
        if (data ==

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
