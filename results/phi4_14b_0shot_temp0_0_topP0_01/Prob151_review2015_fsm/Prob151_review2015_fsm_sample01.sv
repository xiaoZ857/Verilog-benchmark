

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
localparam IDLE = 4'b0001,
           DETECT_1 = 4'b0010,
           DETECT_11 = 4'b0100,
           DETECT_110 = 4'b1000,
           SHIFT = 4'b0001,
           COUNTING = 4'b0010,
           DONE_WAIT_ACK = 4'b0100;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        IDLE: 
            if (data == 1'b1)
                next_state = DETECT_1;
            else
                next_state = IDLE;

        DETECT_1:
            if (data == 1'b1)
                next_state = DETECT_11;
            else
                next_state = IDLE;

        DETECT_11:
            if (data == 1'b0)
                next_state = DETECT_110;
            else
                next_state = IDLE;

        DETECT_110:
            if (data == 1'b1)
                next_state = SHIFT;
            else
                next_state = IDLE;

        SHIFT: 
            if (shift_counter < 4) begin
                shift_ena <= 1;
                next_state = SHIFT;
            end else begin
                shift_ena <= 0;
                counting <= 1;
                next_state = COUNTING;
            end

        COUNTING:
            if (done_counting)
                next_state = DONE_WAIT_ACK;

        DONE_WAIT_ACK:
            if (ack)
                next_state = IDLE;
            else
                next_state = DONE_WAIT_ACK;

        default: 
            next_state = IDLE;
    endcase
end

reg [1:0] shift_counter;

always @(posedge clk) begin
    if (state == SHIFT && shift_ena)
        shift_counter <= shift_counter + 1;
    else
        shift_counter <= 2'b00;
end

always @(*) begin
    case (state)
        IDLE:
            done = 0;

        COUNTING:
            done = 0;

        DONE_WAIT_ACK:
            done = 1;

        default:
            done = 0;
    endcase
end

always @(posedge clk) begin
    if (reset)
        counting <= 0;
    else if (state == SHIFT && shift_counter == 4'b1000)
        counting <= 1;
    else if (state == COUNTING && !done_counting)
        counting <= 1;
    else
        counting <= 0;
end

endmodule
