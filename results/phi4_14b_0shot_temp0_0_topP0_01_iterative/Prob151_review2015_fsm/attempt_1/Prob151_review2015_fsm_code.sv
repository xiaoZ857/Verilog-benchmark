
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
    typedef enum logic [2:0] {
        IDLE = 3'b000,   // Waiting for the start pattern (1101)
        DETECT_1 = 3'b001, // Detected first bit of pattern
        DETECT_11 = 3'b010, // Detected '11' in pattern
        DETECT_110 = 3'b011, // Detected '110' in pattern
        START_SHIFT = 3'b100, // Pattern detected, start shifting
        SHIFTING = 3'b101,    // Shifting in additional bits
        WAIT_COUNT = 3'b110,  // Waiting for counters to finish
        NOTIFY_DONE = 3'b111  // Notifying user of completion
    } state_t;

    state_t current_state, next_state;

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
                    if (&{shift_ena, current_state} == 3'b101)
                        next_state = WAIT_COUNT;
                    else
                        next_state = SHIFTING;
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

endmodule

// VERILOG-EVAL: errant inclusion of module definition
