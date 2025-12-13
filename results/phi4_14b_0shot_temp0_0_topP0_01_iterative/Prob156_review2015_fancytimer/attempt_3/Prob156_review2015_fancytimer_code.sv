
`timescale 1ns / 1ps

module TopModule (
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        DETECT_1 = 3'b001,
        DETECT_11 = 3'b010,
        DETECT_110 = 3'b011,
        DETECT_1101 = 3'b100,
        READ_DELAY = 3'b101,
        COUNTING = 3'b110,
        WAIT_ACK = 3'b111
    } state_t;

    // Internal signals
    reg [2:0] current_state, next_state;
    reg [3:0] delay_value;
    reg [19:0] counter; // 20-bit to count up to 60000 (for max delay=15)
    reg [3:0] remaining_time;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            counting <= 1'b0;
            done <= 1'b0;
            counter <= 20'd0;
            delay_value <= 4'd0;
            remaining_time <= 4'd0;
        end else begin
            current_state <= next_state;

            case (current_state)
                COUNTING: begin
                    if (counter == {delay_value + 4'd1, 12'b0}) begin
                        counting <= 1'b0;
                        done <= 1'b1;
                        counter <= 20'd0;
                    end else begin
                        counter <= counter + 1;
                        remaining_time <= delay_value - (counter[19:16]);
                    end
                end

                WAIT_ACK: begin
                    if (ack) begin
                        counting <= 1'b0;
                        done <= 1'b0;
                        current_state <= IDLE; // Reset to IDLE after ack
                    end
                end

                default: begin
                    counter <= 20'd0;
                    remaining_time <= 4'd0;
                end
            endcase
        end
    end

    always_comb begin
        next_state = current_state; // Default to stay in the same state

        case (current_state)
            IDLE: begin
                if (data) next_state = DETECT_1;
            end

            DETECT_1: begin
                if (!data) next_state = DETECT_11;
                else next_state = IDLE;
            end

            DETECT_11: begin
                if (data) next_state = DETECT_110;
                else next_state = IDLE;
            end

            DETECT_110: begin
                if (!data) next_state = DETECT_1101;
                else next_state = IDLE;
            end

            DETECT_1101: begin
                next_state = READ_DELAY;
            end

            READ_DELAY: begin
                delay_value[3] <= data;
                next_state = READ_DELAY_2;
            end

            READ_DELAY_2: begin
                delay_value[2] <= data;
                next_state = READ_DELAY_3;
            end

            READ_DELAY_3: begin
                delay_value[1] <= data;
                next_state = READ_DELAY_4;
            end

            READ_DELAY_4: begin
                delay_value[0] <= data;
                counting <= 1'b1;
                counter <= 20'd0; // Reset counter for counting
                remaining_time <= delay_value;
                next_state = COUNTING;
            end

            COUNTING: begin
                if (counter == {delay_value + 4'd1, 12'b0}) next_state = WAIT_ACK;
            end

            WAIT_ACK: begin
                if (ack) next_state = IDLE;
            end
        endcase
    end

    always_comb begin
        count = remaining_time; // Output
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
