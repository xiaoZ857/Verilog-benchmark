
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
  localparam IDLE   = 2'b00;
  localparam SHIFT  = 2'b01;
  localparam COUNT  = 2'b10;
  localparam NOTIFY = 2'b11;

  reg [1:0] state, next_state;
  reg [3:0] pattern_reg;  // shift register for pattern detection
  reg [2:0] shift_cnt;    // counter for 4 shift cycles

  // Pattern detection shift register
  always @(posedge clk) begin
    if (reset) begin
      pattern_reg <= 4'b0;
    end else begin
      pattern_reg <= {pattern_reg[2:0], data};
    end
  end

  // Shift counter
  always @(posedge clk) begin
    if (reset) begin
      shift_cnt <= 3'b0;
    end else if (state == SHIFT) begin
      shift_cnt <= shift_cnt + 1;
    end else begin
      shift_cnt <= 3'b0;
    end
  end

  // State register
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
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
        if (shift_cnt == 3'b100) begin  // after 4 shifts
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
  always @(posedge clk) begin
    if (reset) begin
      shift_ena <= 1'b0;
      counting  <= 1'b0;
      done      <= 1'b0;
    end else begin
      // Default outputs
      shift_ena <= 1'b0;
      counting  <= 1'b0;
      done      <= 1'b0;

      case (state)
        SHIFT: begin
          shift_ena <= 1'b1;
        end
        COUNT: begin
          counting <= 1'b1;
        end
        NOTIFY: begin
          done <= 1'b1;
        end
      endcase
    end
  end
endmodule
