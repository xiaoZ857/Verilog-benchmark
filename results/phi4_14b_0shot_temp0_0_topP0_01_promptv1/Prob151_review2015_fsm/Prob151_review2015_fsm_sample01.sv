
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
reg [3:0] state, next_state;
localparam S_IDLE = 4'b0001,
           S_DETECT_1 = 4'b0010,
           S_DETECT_10 = 4'b0100,
           S_DETECT_110 = 4'b1000,
           S_SHIFT = 4'b1010,
           S_COUNTING = 4'b1100,
           S_DONE = 4'b1110;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= S_IDLE;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        S_IDLE: 
            if (data == 1'b1)
                next_state = S_DETECT_1;
            else
                next_state = S_IDLE;

        S_DETECT_1:
            if (data == 1'b1)
                next_state = S_DETECT_10;
            else
                next_state = S_IDLE;

        S_DETECT_10:
            if (data == 1'b0)
                next_state = S_DETECT_110;
            else
                next_state = S_IDLE;

        S_DETECT_110:
            if (data == 1'b1)
                next_state = S_SHIFT;
            else
                next_state = S_IDLE;

        S_SHIFT: 
            if (state[3] == 1'b0) // Shift for exactly 4 cycles
                next_state = S_SHIFT;
            else
                next_state = S_COUNTING;

        S_COUNTING:
            if (done_counting)
                next_state = S_DONE;
            else
                next_state = S_COUNTING;

        S_DONE:
            if (ack)
                next_state = S_IDLE;
            else
                next_state = S_DONE;

        default: 
            next_state = S_IDLE;
    endcase
end

always @(*) begin
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;

    case (state)
        S_SHIFT:
            if (state[3] == 1'b0) // Shift for exactly 4 cycles
                shift_ena = 1'b1;

        S_COUNTING:
            counting = 1'b1;

        S_DONE:
            done = 1'b1;
    endcase
end

endmodule
