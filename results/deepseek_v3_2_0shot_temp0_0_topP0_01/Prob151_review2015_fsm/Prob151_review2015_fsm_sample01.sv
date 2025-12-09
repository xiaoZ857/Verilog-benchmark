
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
  // State encoding
  parameter IDLE   = 2'b00,
            SHIFT  = 2'b01,
            COUNT  = 2'b10,
            NOTIFY = 2'b11;

  reg [1:0] state, next_state;
  reg [2:0] shift_counter;

  // State register
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end

  // Shift counter logic
  always @(posedge clk) begin
    if (reset) begin
      shift_counter <= 3'b0;
    end else if (state == SHIFT) begin
      shift_counter <= shift_counter + 1;
    end else begin
      shift_counter <= 3'b0;
    end
  end

  // Pattern detection shift register
  reg [3:0] pattern_reg;
  always @(posedge clk) begin
    if (reset) begin
      pattern_reg <= 4'b0;
    end else begin
      pattern_reg <= {pattern_reg[2:0], data};
    end
  end

  // Next state logic
  always @(*) begin
    next_state = state;
    case (state)
      IDLE: begin
        if (pattern_reg == 4'b1101) begin
          next_state = SHIFT;
        end
      end
      SHIFT: begin
        if (shift_counter == 3'd3) begin
          next_state = COUNT;
        end
      end
      COUNT: begin
        if (done_counting) begin
          next_state = NOTIFY;
        end
      end
      NOTIFY: begin
        if (ack) begin
          next_state = IDLE;
        end
      end
    endcase
  end

  // Output logic
  always @(*) begin
    shift_ena = 1'b0;
    counting  = 1'b0;
    done      = 1'b0;
    case (state)
      SHIFT:  shift_ena = 1'b1;
      COUNT:  counting  = 1'b1;
      NOTIFY: done      = 1'b1;
      default: ; // keep defaults
    endcase
  end
endmodule
