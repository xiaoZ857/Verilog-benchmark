
module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);

typedef enum {
  IDLE,
  START,
  DATA_RECEIVE,
  STOP,
  ERROR
} state_t;

state_t state = IDLE;
reg [2:0] data_cnt = 0;
reg [7:0] out_byte_reg = 0;
reg done_reg = 0;

always @(posedge clk) begin
  if (reset) begin
    state <= IDLE;
    data_cnt <= 0;
    out_byte_reg <= 0;
    done_reg <= 0;
  end else begin
    case (state)
      IDLE: begin
        if (in == 0) begin
          state <= START;
        end
      end

      START: begin
        state <= DATA_RECEIVE;
        data_cnt <= 7;
        out_byte_reg <= in;
      end

      DATA_RECEIVE: begin
        if (data_cnt > 0) begin
          data_cnt <= data_cnt - 1;
          out_byte_reg <= {out_byte_reg[6:0], in};
        end else begin
          state <= STOP;
        end
      end

      STOP: begin
        if (in == 1) begin
          done_reg <= 1;
          state <= DONE;
        end else begin
          state <= ERROR;
        end
      end

      DONE: begin
        done_reg <= 1;
        // Stay in DONE until reset or after some time to indicate completion
        if (in == 0) begin
          state <= IDLE;
          done_reg <= 0;
        end
      end

      default: begin
        state <= ERROR;
      end
    endcase
  end
end

assign out_byte = out_byte_reg;
assign done = done_reg;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
