
module TopModule (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Define states for FSM
    typedef enum logic [1:0] {
        IDLE,     // Discard bytes until a boundary byte is found
        COLLECT1, // Collecting the first byte of message
        COLLECT2, // Collecting the second byte of message
        COLLECT3  // Collecting the third byte of message
    } state_t;

    state_t current_state, next_state;

    reg [7:0] byte1, byte2; // Registers to hold the first two bytes

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 0;
            out_bytes <= 24'b0;
        end else begin
            current_state <= next_state;
            
            // Update output and done signal based on the state
            case (current_state)
                COLLECT3: begin
                    out_bytes <= {byte1, byte2, in}; 
                    done <= 1;
                end
                default: begin
                    out_bytes <= 24'b0;
                    done <= 0;
                end
            endcase
        end
    end

    always_comb begin
        next_state = current_state; // Default to staying in the same state
        
        case (current_state)
            IDLE: begin
                if (in[3] == 1) begin
                    next_state = COLLECT1;
                    byte1 = in; // Load first byte upon detecting a boundary
                end
            end

            COLLECT1: begin
                byte2 = in;
                next_state = COLLECT2;
            end

            COLLECT2: begin
                next_state = COLLECT3;
            end
            
            COLLECT3: begin
                next_state = IDLE; // Start over after completing a message
            end
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
