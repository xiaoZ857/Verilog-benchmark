
module TopModule (
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack
);
  // FSM states
  localparam IDLE        = 2'b00;
  localparam SHIFT_DELAY = 2'b01;
  localparam COUNTING    = 2'b10;
  localparam DONE        = 2'b11;

  reg [1:0] state, next_state;
  reg [3:0] seq_reg;          // shift register for sequence detection
  reg [3:0] delay_reg;        // shift register for delay value
  reg [2:0] bit_cnt;          // counts 0..3 for shifting delay bits
  reg [9:0] cycle_cnt;        // counts 0..999 for each 1000-cycle period
  reg [3:0] delay_val;        // stored delay value after shifting complete
  reg [3:0] rem_time;         // remaining time (delay_val down to 0)

  // State register
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end

  // Sequence detection shift register
  always @(posedge clk) begin
    if (reset) begin
      seq_reg <= 4'b0;
    end else if (state == IDLE) begin
      seq_reg <= {seq_reg[2:0], data};
    end
  end

  // Next state logic
  always @(*) begin
    next_state = state;
    case (state)
      IDLE: begin
        if (seq_reg == 4'b1101) begin
          next_state = SHIFT_DELAY;
        end
      end
      SHIFT_DELAY: begin
        if (bit_cnt == 3) begin
          next_state = COUNTING;
        end
      end
      COUNTING: begin
        if (cycle_cnt == 10'd999 && rem_time == 4'd0) begin
          next_state = DONE;
        end
      end
      DONE: begin
        if (ack) begin
          next_state = IDLE;
        end
      end
    endcase
  end

  // Bit counter for shifting delay bits
  always @(posedge clk) begin
    if (reset) begin
      bit_cnt <= 3'd0;
    end else begin
      case (state)
        IDLE: bit_cnt <= 3'd0;
        SHIFT_DELAY: begin
          if (bit_cnt == 3) begin
            bit_cnt <= 3'd0;
          end else begin
            bit_cnt <= bit_cnt + 1;
          end
        end
        default: bit_cnt <= 3'd0;
      endcase
    end
  end

  // Delay shift register
  always @(posedge clk) begin
    if (reset) begin
      delay_reg <= 4'b0;
    end else if (state == SHIFT_DELAY) begin
      delay_reg <= {delay_reg[2:0], data};
    end
  end

  // Store delay value when shifting is complete
  always @(posedge clk) begin
    if (reset) begin
      delay_val <= 4'b0;
    end else if (state == SHIFT_DELAY && bit_cnt == 3) begin
      delay_val <= {delay_reg[2:0], data}; // final bit included
    end
  end

  // Cycle counter (0 to 999)
  always @(posedge clk) begin
    if (reset) begin
      cycle_cnt <= 10'd0;
    end else begin
      case (state)
        COUNTING: begin
          if (cycle_cnt == 10'd999) begin
            cycle_cnt <= 10'd0;
          end else begin
            cycle_cnt <= cycle_cnt + 1;
          end
        end
        default: cycle_cnt <= 10'd0;
      endcase
    end
  end

  // Remaining time counter
  always @(posedge clk) begin
    if (reset) begin
      rem_time <= 4'd0;
    end else begin
      case (state)
        SHIFT_DELAY: begin
          if (bit_cnt == 3) begin
            rem_time <= {delay_reg[2:0], data}; // same as delay_val
          end
        end
        COUNTING: begin
          if (cycle_cnt == 10'd999) begin
            if (rem_time != 4'd0) begin
              rem_time <= rem_time - 1;
            end
          end
        end
        default: rem_time <= 4'd0;
      endcase
    end

// VERILOG-EVAL: endmodule not found
