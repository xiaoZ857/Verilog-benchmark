
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output reg walk_left,
  output reg walk_right
);

    // State encoding: 2 states, so we need only one bit.
    typedef enum logic [0:0] {
        WALK_LEFT = 1'b1,   // Lemming is walking left
        WALK_RIGHT = 1'b0   // Lemming is walking right
    } state_t;

    // Declare the current and next state variables
    state_t current_state, next_state;

    // State transition logic and output assignment (Mealy machine approach)
    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                walk_left = 1;   // Walking left in this state
                walk_right = 0;
                
                if (bump_left || bump_right) begin
                    next_state = WALK_RIGHT;  // Switch direction on a bump
                end else begin
                    next_state = WALK_LEFT;
                end
            end

            WALK_RIGHT: begin
                walk_right = 1;   // Walking right in this state
                walk_left = 0;

                if (bump_left || bump_right) begin
                    next_state = WALK_LEFT;   // Switch direction on a bump
                end else begin
                    next_state = WALK_RIGHT;
                end
            end

        endcase
    end

    // State register update with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;  // Asynchronous reset to walk left
        end else begin
            current_state <= next_state;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
