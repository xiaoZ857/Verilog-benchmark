
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
  reg [3:0] seq_reg;          // shift register for sequence detection
  reg [1:0] shift_cnt;        // counter for 4 shift cycles

  // State register
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end

  // Sequence shift register
  always @(posedge clk) begin
    if (reset) begin
      seq_reg <= 4'b0;
    end else begin
      seq_reg <= {seq_reg[2:0], data};
    end
  end

  // Shift counter
  always @(posedge clk) begin
    if (reset) begin
      shift_cnt <= 2'b0;
    end else if (state == SHIFT) begin
      shift_cnt <= shift_cnt + 1;
    end else begin
      shift_cnt <= 2'b0;
    end
  end

  // Next state logic
  always @(*) begin
    case (state)
      IDLE: begin
        if (seq_reg == 4'b1101) begin
          next_state = SHIFT;
        end else begin
          next_state = IDLE;
        end
      end
      SHIFT: begin
        if (shift_cnt == 2'b11) begin  // after 4 cycles (0,1,2,3)
          next_state = COUNT;
        end else begin
          next_state = SHIFT;
        end
      end
      COUNT: begin
        if (done_counting) begin
          next_state = NOTIFY;
        end else begin
          next_state = COUNT;
        end
      end
      NOTIFY: begin
        if (ack) begin
          next_state = IDLE;
        end else begin
          next_state = NOTIFY;
        end
      end
      default: next_state = IDLE;
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
