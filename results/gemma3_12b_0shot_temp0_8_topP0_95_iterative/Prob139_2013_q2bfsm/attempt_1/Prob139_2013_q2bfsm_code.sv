
module TopModule (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);

  // State definition
  typedef enum logic [1:0] {
    STATE_A,
    STATE_F_ONE,
    STATE_X_MONITOR,
    STATE_G_ONE,
    STATE_Y_MONITOR_1,
    STATE_Y_MONITOR_2
  } state_t;

  state_t current_state, next_state;

  // Internal signals
  logic x_prev, x_prev_prev;
  logic g_active;
  logic y_monitor_counter;

  // State register
  always_ff @(posedge clk, negedge resetn) begin
    if (!resetn) begin
      current_state <= STATE_A;
      g_active <= 0;
      y_monitor_counter <= 0;
    end else begin
      current_state <= next_state;
      if (next_state == STATE_G_ONE) begin
        g_active <= 1;
      end else begin
        g_active <= g_active;
      end
      if (next_state == STATE_Y_MONITOR_1 || next_state == STATE_Y_MONITOR_2) begin
          y_monitor_counter <= 0;
      end else begin
          y_monitor_counter <= y_monitor_counter;
      end
    end
  end

  // Next state logic
  always_comb begin
    next_state = current_state;

    case (current_state)
      STATE_A: begin
        if (!resetn) begin
          next_state = STATE_A;
        end else begin
          next_state = STATE_F_ONE;
        end
      end
      STATE_F_ONE: begin
        next_state = STATE_X_MONITOR;
      end
      STATE_X_MONITOR: begin
        if (x == 1) begin
          next_state = STATE_X_MONITOR;
        end else if (x == 0) begin
          next_state = STATE_X_MONITOR;
        end else begin
          next_state = STATE_X_MONITOR;
        end
      end
      STATE_G_ONE: begin
        next_state = STATE_Y_MONITOR_1;
      end
      STATE_Y_MONITOR_1: begin
        if (y == 1) begin
          next_state = STATE_G_ONE;
        end else begin
          next_state = STATE_Y_MONITOR_2;
        end
      end
      STATE_Y_MONITOR_2: begin
        if (y == 1) begin
          next_state = STATE_G_ONE;
        end else begin
          next_state = STATE_G_ONE;
        end
      end
      default: begin
        next_state = STATE_A;
      end
    endcase
  end

  // Output logic
  always_comb begin
    f = 0;
    g = 0;

    case (current_state)
      STATE_F_ONE: begin
        f = 1;
      end
      STATE_G_ONE: begin
        g = 1;
      end
      default: begin
        f = 0;
        g = 0;
      end
    endcase
  end

  // Sequential logic for x monitoring
  always_ff @(posedge clk, negedge resetn) begin
    if (!resetn) begin
      x_prev = 0;
      x_prev_prev = 0;
    end else begin
      x_prev = x;
      x_prev_prev = x_prev_prev;
    end
  end

  always_ff @(posedge clk, negedge resetn) begin
    if (!resetn) begin
        y_monitor_counter <= 0;
    end else if (current_state == STATE_Y_MONITOR_1) begin
        if (y == 1) begin
            y_monitor_counter <= 0;
        end else begin
            y_monitor_counter <= y_monitor_counter + 1;
        end
    end else if (current_state == STATE_Y_MONITOR_2) begin
        if (y == 1

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
