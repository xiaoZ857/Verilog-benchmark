
module TopModule (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // Define states for FSM
    typedef enum logic [1:0] {
        IDLE,      // Waiting for a byte with in[3] = 1
        RECV_BYTE1,// Received first byte of the message
        RECV_BYTE2,// Received second byte of the message
        RECV_BYTE3 // Received third byte of the message
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always_comb begin
        // Default assignments
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (in[3] == 1) 
                    next_state = RECV_BYTE1;
                else
                    next_state = IDLE;
            end
            
            RECV_BYTE1: begin
                next_state = RECV_BYTE2;
            end

            RECV_BYTE2: begin
                next_state = RECV_BYTE3;
            end

            RECV_BYTE3: begin
                done = 1'b1; // Indicate the message is complete
                next_state = IDLE;
            end

            default: 
                next_state = IDLE;
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
