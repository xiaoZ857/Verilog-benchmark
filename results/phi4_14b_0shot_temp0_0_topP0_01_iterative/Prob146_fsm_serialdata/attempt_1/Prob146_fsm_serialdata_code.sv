
module TopModule (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START_BIT = 3'b001,
        RECEIVE_DATA = 3'b010,
        STOP_BIT = 3'b011,
        CHECK_STOP = 3'b100
    } state_t;

    // State register
    reg [2:0] current_state, next_state;

    // Data bit counter
    reg [2:0] bit_counter;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b00000000;
            done <= 1'b0;
            bit_counter <= 3'b000;
        end else begin
            current_state <= next_state;

            case (current_state)
                START_BIT: begin
                    if (in == 1'b0) begin
                        bit_counter <= 3'b000; // Reset counter for data bits
                    end
                end

                RECEIVE_DATA: begin
                    out_byte[bit_counter] <= in;
                    bit_counter <= bit_counter + 1'b1;
                end

                STOP_BIT: begin
                    if (in == 1'b1) begin
                        next_state <= CHECK_STOP;
                    end else begin
                        // If stop bit is not correct, go back to IDLE
                        next_state <= IDLE;
                    end
                end

                CHECK_STOP: begin
                    done <= 1'b1; // Assert done when a valid byte is received
                    next_state <= IDLE;
                end

                default: begin
                    if (in == 1'b1) begin
                        next_state <= START_BIT;
                    end else begin
                        next_state <= current_state;
                    end
                end
            endcase
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START_BIT;
                end else begin
                    next_state = IDLE;
                end
            end

            START_BIT: begin
                if (in == 1'b0) begin
                    next_state = RECEIVE_DATA;
                end else begin
                    next_state = IDLE;
                end
            end

            RECEIVE_DATA: begin
                if (bit_counter == 3'b111) begin
                    next_state = STOP_BIT;
                end else begin
                    next_state = RECEIVE_DATA;
                end
            end

            STOP_BIT: begin
                if (in == 1'b1) begin
                    next_state = CHECK_STOP;
                end else begin
                    next_state = IDLE;
                end
            end

            CHECK_STOP: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
