
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
always_ff @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= IDLE;
    else
        current_state <= next_state;
end

always_comb begin
    // Default outputs
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;

    case (current_state)
        IDLE: begin
            if (data == 1'b1) 
                next_state = DETECT_1;
            else
                next_state = IDLE;
        end

        DETECT_1: begin
            if (data == 1'b1)
                next_state = DETECT_11;
            else
                next_state = IDLE;
        end

        DETECT_11: begin
            if (data == 1'b0)
                next_state = DETECT_110;
            else
                next_state = DETECT_11; // Stay in this state for another '1'
        end

        DETECT_110: begin
            if (data == 1'b1)
                next_state = START_SHIFT;
            else
                next_state = IDLE;
        end

        START_SHIFT: begin
            shift_ena = 1'b1; // Assert shift enable for one cycle
            next_state = SHIFTING;
        end

        SHIFTING: begin
            if (shift_ena == 0) begin
                shift_ena = 1'b1; // Keep shifting for exactly 4 cycles
                if (current_state == SHIFTING && shift_count < 3)
                    next_state = SHIFTING;
                else
                    next_state = WAIT_COUNT;
            end else begin
                shift_ena = 1'b0;
                next_state = SHIFTING; // Continue shifting
            end
        end

        WAIT_COUNT: begin
            counting = 1'b1; // Indicate waiting for counters
            if (done_counting)
                next_state = NOTIFY_DONE;
            else
                next_state = WAIT_COUNT;
        end

        NOTIFY_DONE: begin
            done = 1'b1; // Notify user of completion
            if (ack)
                next_state = IDLE;
            else
                next_state = NOTIFY_DONE;
        end

        default: next_state = IDLE;
    endcase
end

// Additional logic to count the number of SHIFTING cycles
reg [1:0] shift_count;

always_ff @(posedge clk or posedge reset) begin
    if (reset)
        shift_count <= 2'b00;
    else if (current_state == START_SHIFT)
        shift_count <= 2'b00; // Reset count when starting to shift
    else if (shift_ena && current_state == SHIFTING)
        shift_count <= shift_count + 1'b1; // Increment count during shifting
end

endmodule
