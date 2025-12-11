
module TopModule (
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack
);
logic [3:0] shift_reg;
logic start;
logic [3:0] delay;
logic waiting_for_delay;
logic [3:0] timer_count;
logic timer_done;

always @(posedge clk) begin
  if (reset) begin
    shift_reg <= 0;
    start <= 0;
    delay <= 0;
    waiting_for_delay <= 0;
    timer_count <= 0;
    timer_done <= 0;
    counting <= 0;
    done <= 0;
  end else begin
    if (!waiting_for_delay) begin
      if (data) begin
        shift_reg <= {shift_reg[3], data};
        if (shift_reg == 4'b1101) begin
          start <= 1;
        end
      end
    end else begin
      shift_reg <= {shift_reg[3], 1'b0};
    end

    if (start) begin
      waiting_for_delay <= 1;
      start <= 0;
      for (integer i = 0; i < 4; i++) begin
        delay <= {delay[3], data};
      end
    end

    if (waiting_for_delay) begin
      if (delay[3] == 0) begin
        timer_count <= 1000;
        counting <= 1;
        waiting_for_delay <= 0;
      end else begin
        timer_count <= delay;
        counting <= 1;
        waiting_for_delay <= 0;
      end
    end

    if (counting) begin
      if (timer_count > 0) begin
        timer_count <= timer_count - 1;
        count <= timer_count[3:0];
      end else begin
        counting <= 0;
        timer_done <= 1;
        count <= 0;
      end
    end

    if (timer_done) begin
      done <= 1;
      if (ack) begin
        done <= 0;
        timer_done <= 0;
      end
    end
  end
endmodule
