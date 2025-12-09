
module TopModule (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

    typedef enum logic [2:0] {
        WL = 3'b001, // Walking Left
        WR = 3'b010, // Walking Right
        FALLING = 3'b100, // Falling
        DIGGING = 3'b011  // Digging
    } state_t;

    state_t current_state, next_state;
    reg [4:0] fall_counter; // Counter for tracking falling duration

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WL;
            fall_counter <= 5'b00000;
        end else begin
            current_state <= next_state;
            if (current_state == FALLING && ground)
                fall_counter <= 0; // Reset counter when hitting the ground
            else if (fall_counter < 20 && current_state == FALLING)
                fall_counter <= fall_counter + 1; // Increment only while falling
        end
    end

    always_comb begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (current_state)
            WL: begin
                walk_left = 1;
                if (ground == 0) next_state = FALLING;
                else if (dig && ground) next_state = DIGGING;
                else if (bump_left || (!bump_right && bump_left)) next_state = WR;
                else next_state = WL;
            end

            WR: begin
                walk_right = 1;
                if (ground == 0) next_state = FALLING;
                else if (dig && ground) next_state = DIGGING;
                else if (bump_right || (!bump_left && bump_right)) next_state = WL;
                else next_state = WR;
            end

            FALLING: begin
                aaah = 1;
                if (ground == 0 || fall_counter >= 20) next_state = current_state; // Stay or splatter
                else if (ground) next_state = current_state; // Continue falling
                else next_state = (fall_counter < 20) ? current_state : FALLING; // Splatter condition
            end

            DIGGING: begin
                digging = 1;
                if (ground == 0 || fall_counter >= 20) next_state = current_state; // Stay or splatter
                else if (!ground || dig == 0) next_state = (fall_counter < 20) ? ((current_state == WL) ? WL : WR) : FALLING;
            end

        endcase

        if (fall_counter >= 20 && ground) begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
