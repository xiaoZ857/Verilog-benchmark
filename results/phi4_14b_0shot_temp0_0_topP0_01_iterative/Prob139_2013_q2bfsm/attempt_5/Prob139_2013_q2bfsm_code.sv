
module TopModule (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic [2:0] {
        STATE_A = 3'b000,  // Initial state
        STATE_B = 3'b001,  // After setting f = 1 for one cycle
        STATE_C = 3'b010,  // x == 1 detected
        STATE_D = 3'b011,  // x == 0 after x == 1
        STATE_E = 3'b100,  // x == 1 again (after x == 0)
        STATE_F = 3'b101,  // g is set to 1, waiting for y = 1 within two cycles
        STATE_G   = 3'b110, // g remains 1 permanently
        STATE_H   = 3'b111  // Temporary state for checking y within two cycles
    } state_t;

    state_t current_state, next_state;
    reg [1:0] y_counter; // Counter to track y detection within two cycles

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= STATE_A;
        else
            current_state <= next_state;

        if (current_state == STATE_F && y == 1) begin
            y_counter <= 2'b11; // Reset counter when y is detected
        end else if (y_counter != 2'b11) begin
            y_counter <= y_counter + 1;
        end
    end

    always_comb begin
        // Default outputs and transitions
        f = 0;
        g = 0;

        case (current_state)
            STATE_A: begin
                f = 1; // Set f to 1 for one cycle
                next_state = STATE_B;
            end
            STATE_B: begin
                if (x == 1) 
                    next_state = STATE_C;
                else 
                    next_state = STATE_B; // Stay in STATE_B until x is 1
            end
            STATE_C: begin
                if (x == 0)
                    next_state = STATE_D;
                else 
                    next_state = STATE_C; // Stay in STATE_C until x is 0
            end
            STATE_D: begin
                if (x == 1) 
                    next_state = STATE_F;
                else 
                    next_state = STATE_B; // Reset sequence if x != 1
            end
            STATE_F: begin
                g = 1; // Set g to 1
                if (y_counter == 2'b11)
                    next_state = STATE_G; // y detected, stay in STATE_G
                else 
                    next_state = STATE_H; // Move to check for y within two cycles
            end
            STATE_H: begin
                if (y_counter == 2'b11) 
                    next_state = STATE_G;
                else 
                    next_state = STATE_A; // No y detected, reset sequence
            end
            STATE_G: begin
                // Permanent state where g remains 1
                f = 0;
                g = 1;
                next_state = STATE_G;
            end
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
