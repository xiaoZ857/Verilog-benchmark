
module TopModule (
    input wire clk,
    input wire areset,
    input wire bump_left,
    input wire bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State definitions
    typedef enum logic [1:0] { 
        IDLE_LEFT,  // 00: Walk left
        IDLE_RIGHT  // 01: Walk right
    } state_t;

    // Current and next state registers
    state_t current_state, next_state;

    // Asynchronous reset and synchronous state update logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE_LEFT;  // Reset to walk left on areset
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE_LEFT: begin
                if (bump_left || bump_right) begin
                    next_state = IDLE_RIGHT;  // Switch to walk right on any bump
                end else begin
                    next_state = IDLE_LEFT;   // Remain walking left if no bump
                end
            end

            IDLE_RIGHT: begin
                if (bump_left || bump_right) begin
                    next_state = IDLE_LEFT;  // Switch to walk left on any bump
                end else begin
                    next_state = IDLE_RIGHT;  // Remain walking right if no bump
                end
            end

            default: begin
                next_state = IDLE_LEFT;  // Default state is walk left
            end
        endcase
    end

    // Output logic based on current state
    always @(*) begin
        case (current_state)
            IDLE_LEFT: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            
            IDLE_RIGHT: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
            end

            default: begin
                walk_left = 1'b1;   // Default to walking left if undefined state
                walk_right = 1'b0;
            end
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
