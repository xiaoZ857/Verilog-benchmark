
module TopModule (
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack
);

  // State definition
  typedef enum logic [2:0] {
    IDLE,
    DETECT_1,
    DETECT_11,
    DETECT_110,
    DETECT_1101,
    SHIFT_DELAY,
    COUNTING,
    DONE
  } state_t;

  reg state, next_state;

  // Delay register
  reg [3:0] delay;

  // Counter for counting cycles
  reg [15:0] cycle_counter;

  // Internal signals
  reg [3:0] shift_reg;

  // State transition logic
  always_comb begin
    next_state = state;
    case (state)
      IDLE: begin
        if (data == 1) begin
          next_state = DETECT_1;
        end else begin
          next_state = IDLE;
        end
      end
      DETECT_1: begin
        if (data == 1) begin
          next_state = DETECT_11;
        end else begin
          next_state = IDLE;
        end
      end
      DETECT_11: begin
        if (data == 0) begin
          next_state = DETECT_110;
        end else begin
          next_state = DETECT_1;
        end
      end
      DETECT_110: begin
        if (data == 1) begin
          next_state = DETECT_1101;
        end else begin
          next_state = DETECT_11;
        end
      end
      DETECT_1101: begin
        next_state = SHIFT_DELAY;
      end
      SHIFT_DELAY: begin
        next_state = COUNTING;
      end
      COUNTING: begin
        next_state = COUNTING;
      end
      DONE: begin
        if (ack == 1) begin
          next_state = IDLE;
        end else begin
          next_state = DONE;
        end
      end
      default: next_state = IDLE;
    endcase
  end

  // State register
  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end

  // Shift register logic
  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      shift_reg <= 0;
    end else begin
      if (state == SHIFT_DELAY) begin
        shift_reg <= {shift_reg[2:0], data};
      end
    end
  end

  // Delay register logic
  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      delay <= 0;
    end else begin
      if (state == SHIFT_DELAY) begin
        delay <= shift_reg;
      end
    end
  end

  // Counter logic
  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      cycle_counter <= 0;
    end else begin
      if (state == COUNTING) begin
        if (cycle_counter == 999) begin
          cycle_counter <= 0;
        end else begin
          cycle_counter <= cycle_counter + 1;
        end
      end else begin
        cycle_counter <= 0;
      end
    end
  end

  // Output logic
  always_comb begin
    counting = (state == COUNTING);
    done = (state == DONE);

    if (counting) begin
      count = (delay - cycle_counter / 1000);
    end else begin
      count = 0;
    end
  end

  // Transition to DONE state
  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      done <= 0;
    end else begin
      if (state == COUNTING) begin
        if (cycle_counter == 999) begin
          done <= 1;
        end else begin

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
