
module TopModule (
    input wire clk,
    input wire resetn,
    input wire x,
    input wire y,
    output reg f,
    output reg g
);

    // State encoding with unique values for each state
    typedef enum logic [3:0] {
        STATE_A = 4'd0,  // Initial state
        STATE_F1 = 4'd1, // Output f = 1 for one clock cycle
        STATE_X0 = 4'd2, // Waiting for x=1 after f was set
        STATE_X1 = 4'd3, // x = 1 detected, waiting for x=0
        STATE_G1 = 4'd4, // x = 0 followed by x=1 detected, setting g = 1
        STATE_YWAIT_1 = 4'd5, // First wait cycle for y=1 after g=1
        STATE_YWAIT_2 = 4'd6, // Second wait cycle for y=1 after g=1
        STATE_HOLD_G1 = 4'd7, // Permanently hold g=1 if y became 1 in time
        STATE_CLEAR_G = 4'd8   // Clear g = 0 permanently
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    always_comb begin
        // Default values for outputs and state transition
        f = 0;
        g = (current_state == STATE_HOLD_G1);
        
        case (current_state)
            STATE_A: begin
                if (!resetn) begin
                    next_state = STATE_F1;
                end else begin
                    next_state = STATE_A;
                end
            end

            STATE_F1: begin
                f = 1; // Set f to 1 for one clock cycle
                next_state = STATE_X0;
            end

            STATE_X0: begin
                if (x == 1) begin
                    next_state = STATE_X1;
                end else begin
                    next_state = STATE_A;
                end
            end

            STATE_X1: begin
                if (x == 0) begin
                    next_state = STATE_G1;
                end else begin
                    next_state = STATE_A;
                end
            end

            STATE_G1: begin
                g = 1; // Set g to 1
                next_state = STATE_YWAIT_1;
            end

            STATE_YWAIT_1: begin
                if (y == 1) begin
                    next_state = STATE_HOLD_G1;
                end else begin
                    next_state = STATE_YWAIT_2;
                end
            end
            
            STATE_YWAIT_2: begin
                if (y == 1) begin
                    next_state = STATE_HOLD_G1;
                end else begin
                    next_state = STATE_CLEAR_G;
                end
            end

            STATE_HOLD_G1: begin
                next_state = STATE_HOLD_G1; // Remain in this state
            end

            STATE_CLEAR_G: begin
                g = 0; // Set g to 0 permanently
                next_state = STATE_A; // Or stay in clear G if design requires reset only transition
            end

            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
