
module TopModule (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE,      // 000
        ONE_1,     // 001
        ONE_11,    // 010
        ONE_111,   // 011
        ONE_1111,  // 100
        ONE_11110, // 101
        FLAG,      // 110
        ERROR      // 111
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            IDLE: begin
                if (in == 1) begin
                    next_state = ONE_1;
                end else begin
                    next_state = IDLE;
                end
            end

            ONE_1: begin
                if (in == 1) begin
                    next_state = ONE_11;
                end else begin
                    next_state = IDLE;
                end
            end

            ONE_11: begin
                if (in == 1) begin
                    next_state = ONE_111;
                end else begin
                    next_state = IDLE;
                end
            end

            ONE_111: begin
                if (in == 1) begin
                    next_state = ONE_1111;
                end else begin
                    next_state = IDLE;
                end
            end

            ONE_1111: begin
                if (in == 1) begin
                    next_state = ONE_11110;
                end else if (in == 0) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end

            ONE_11110: begin
                if (in == 0) begin
                    next_state = FLAG;
                end else if (in == 1) begin
                    next_state = ERROR;
                end else begin
                    next_state = IDLE;
                end
            end

            FLAG: begin
                if (in == 0) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end

            ERROR: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

    always_ff @(posedge clk) begin
        if (current_state == ONE_11110 && in == 0) begin
            disc <= 1'b1; // Assert discard for one cycle
        end else if (current_state == FLAG) begin
            flag <= 1'b1; // Assert flag for one cycle
        end else if (current_state == ERROR) begin
            err <= 1'b1; // Assert error for one cycle
        end else begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
