
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
  localparam S_IDLE       = 2'b00;
  localparam S_SHIFT_DELAY = 2'b01;
  localparam S_COUNTING   = 2'b10;
  localparam S_DONE       = 2'b11;

  reg [1:0] state, next_state;
  reg [3:0] seq_reg;           // shift register for detecting 1101
  reg [3:0] delay_reg;         // shift register for delay[3:0]
  reg [2:0] bit_cnt;           // counts 0..3 for shifting delay bits
  reg [9:0] cycle_cnt;         // counts 0..999 for each 1000-cycle block
  reg [3:0] delay_val;         // stored delay value after shifting complete
  reg [3:0] count_reg;         // current remaining time (delay_val down to 0)

  // State register
  always @(posedge clk) begin
    if (reset) begin
      state <= S_IDLE;
    end else begin
      state <= next_state;
    end
  end

  // Sequence detection shift register
  always @(posedge clk) begin
    if (reset) begin
      seq_reg <= 4'b0;
    end else if (state == S_IDLE) begin
      seq_reg <= {seq_reg[2:0], data};
    end
  end

  // Next state logic
  always @(*) begin
    case (state)
      S_IDLE: begin
        if (seq_reg == 4'b1101) begin
          next_state = S_SHIFT_DELAY;
        end else begin
          next_state = S_IDLE;
        end
      end
      S_SHIFT_DELAY: begin
        if (bit_cnt == 3'd3) begin
          next_state = S_COUNTING;
        end else begin
          next_state = S_SHIFT_DELAY;
        end
      end
      S_COUNTING: begin
        if ((cycle_cnt == 10'd999) && (count_reg == 4'd0)) begin
          next_state = S_DONE;
        end else begin
          next_state = S_COUNTING;
        end
      end
      S_DONE: begin
        if (ack) begin
          next_state = S_IDLE;
        end else begin
          next_state = S_DONE;
        end
      end
      default: next_state = S_IDLE;
    endcase
  end

  // bit_cnt: counts 0..3 for shifting delay bits
  always @(posedge clk) begin
    if (reset) begin
      bit_cnt <= 3'd0;
    end else begin
      case (state)
        S_IDLE: bit_cnt <= 3'd0;
        S_SHIFT_DELAY: begin
          if (bit_cnt == 3'd3) begin
            bit_cnt <= 3'd0;
          end else begin
            bit_cnt <= bit_cnt + 3'd1;
          end
        end
        default: bit_cnt <= 3'd0;
      endcase
    end
  end

  // delay_reg shift register (MSB first)
  always @(posedge clk) begin
    if (reset) begin
      delay_reg <= 4'b0;
    end else if (state == S_SHIFT_DELAY) begin
      delay_reg <= {delay_reg[2:0], data};
    end
  end

  // Store delay_val when shifting is complete
  always @(posedge clk) begin
    if (reset) begin
      delay_val <= 4'b0;
    end else if ((state == S_SHIFT_DELAY) && (bit_cnt == 3'd3)) begin
      delay_val <= {delay_reg[2:0], data};
    end
  end

  // cycle_cnt: counts 0 to 999 for each 1000-cycle block
  always @(posedge clk) begin
    if (reset) begin
      cycle_cnt <= 10'd0;
    end else if (state == S_COUNTING) begin
      if (cycle_cnt == 10'd999) begin
        cycle_cnt <= 10'd0;
      end else begin
        cycle_cnt <= cycle_cnt + 10'd1;
      end
    end else begin
      cycle_cnt <= 10'd0;
    end
  end

  // count_reg: decrements every 1000 cycles
  always @(posedge clk) begin
    if (reset) begin
      count_reg <= 4'b0;
    end else if (state == S

// VERILOG-EVAL: endmodule not found
