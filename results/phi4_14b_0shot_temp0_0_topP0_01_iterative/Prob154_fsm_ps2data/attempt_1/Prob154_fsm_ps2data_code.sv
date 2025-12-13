
module TopModule (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE,       // Waiting for a start byte
        COLLECT_1,  // Collecting the first byte of the message
        COLLECT_2,  // Collecting the second byte of the message
        COLLECT_3   // Collecting the third byte of the message
    } state_t;

    state_t current_state, next_state;
    
    reg [7:0] byte1, byte2; // Registers to store bytes

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 24'b0;
            done <= 1'b0;
            byte1 <= 8'b0;
            byte2 <= 8'b0;
        end else begin
            current_state <= next_state;

            case (current_state)
                COLLECT_3: begin
                    if (done) begin
                        out_bytes <= {byte1, byte2, in};
                    end
                end
                default: begin
                    // Clear outputs when not done
                    out_bytes <= 24'b0;
                end
            endcase

            done <= (current_state == COLLECT_3);
        end
    end

    always_comb begin
        next_state = current_state; // Default to stay in the same state
        case (current_state)
            IDLE: begin
                if (in[7] == 1'b1) begin
                    next_state = COLLECT_1;
                end
            end
            COLLECT_1: begin
                byte1 = in; // Store first byte
                next_state = COLLECT_2;
            end
            COLLECT_2: begin
                byte2 = in; // Store second byte
                next_state = COLLECT_3;
            end
            COLLECT_3: begin
                // Automatically transition back to IDLE after collecting the third byte
                if (done) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
