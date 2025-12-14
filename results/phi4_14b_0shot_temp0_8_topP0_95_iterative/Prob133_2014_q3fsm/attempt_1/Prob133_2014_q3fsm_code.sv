
module TopModule (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define state encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10
    } state_t;

    state_t current_state, next_state;
    
    // Counters for tracking occurrences of w in three cycles
    reg [1:0] count_w; // Counts how many times w = 1 in the last three clock cycles

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_A;
            count_w <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            // Only update the count in STATE_B
            if (current_state == STATE_B) begin
                count_w <= {count_w[0], w};
            end
            
            // Set output z only when transitioning from STATE_C to STATE_B
            if (current_state == STATE_C) begin
                z <= 1'b1;
            end else begin
                z <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = current_state; // Default to no state change
        
        case (current_state)
            STATE_A: begin
                if (s == 1) 
                    next_state = STATE_B;
            end
            
            STATE_B: begin
                if ((count_w == 2'b10 || count_w == 2'b01)) // Exactly two '1's in three cycles
                    next_state = STATE_C;
                else 
                    next_state = STATE_B;
            end

            STATE_C: begin
                next_state = STATE_B; // Always return to checking state B
            end
            
            default: next_state = STATE_A;
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
