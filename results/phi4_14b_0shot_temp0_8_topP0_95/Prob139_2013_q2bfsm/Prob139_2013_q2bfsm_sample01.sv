
module TopModule (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A,  // Initial state
        STATE_B,  // After setting f = 1 for one clock cycle
        STATE_C,  // Waiting for x to be 1
        STATE_D,  // x was 1, waiting for x to be 0
        STATE_E,  // x was 1, then 0; now waiting for x to be 1 again
        STATE_F,  // g is set to 1, monitoring y
        STATE_G   // Permanently setting g = 0 (if y not received within two cycles)
    } state_t;

    state_t current_state, next_state;

    // Registers to track the sequence of x inputs
    reg [1:0] x_counter; // To count occurrences of specific x values

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 0;
            g <= 0;
            x_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            case (next_state)
                STATE_B: f <= 1; // Set f = 1 for one clock cycle
                default: f <= 0;
            endcase
            case (current_state)
                STATE_F: g <= 1;
                STATE_G: g <= 0;
                default: g <= g; // Hold previous value of g
            endcase
        end
    end

    always_comb begin
        next_state = current_state; // Default to staying in the same state
        x_counter = x_counter; // Default to maintaining the counter

        case (current_state)
            STATE_A: if (!resetn) next_state = STATE_B;

            STATE_B: next_state = STATE_C;
            
            STATE_C: if (x == 1'b1) next_state = STATE_D;

            STATE_D: if (x == 1'b0) next_state = STATE_E;

            STATE_E: begin
                if (x == 1'b1) next_state = STATE_F;
                else next_state = STATE_C; // Reset sequence if not complete
            end

            STATE_F: begin
                if (y == 1'b1) next_state = STATE_F; // Stay in state F if y is detected
                else if (x_counter >= 2'b10) next_state = STATE_G; // If two cycles pass without y=1, go to STATE_G
                x_counter <= x_counter + 1;
            end

            STATE_G: begin
                g <= 0; // Permanently set g = 0 unless reset occurs
            end
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
