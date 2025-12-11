
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
always @(posedge clk) begin
    if (reset)
        state <= START;
    else begin
        case (state)
            START:
                if ((data == 1101) && !shifted_in_progress) begin
                    state <= FOUND;
                end
            FOUND:
                state <= SHIFTED;
            SHIFTED:
                state <= COUNTING;
            COUNTING:
                if (done_counting) begin
                    done <= 1;
                    state <= DONE;
                end
            DONE:
                if (ack) begin
                    state <= START;
                    done <= 0;
                end
        endcase
    end

    case (state)
        FOUND:
            shift_ena <= 1;
        SHIFTED, COUNTING, DONE:
           

// VERILOG-EVAL: endmodule not found
