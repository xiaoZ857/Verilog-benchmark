
module TopModule (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,  // Initial/reset state
        STATE_B = 2'b01   // Monitoring state for `w`
    } state_t;

    state_t current_state, next_state;
    
    reg [1:0] w_count;  // To count occurrences of w=1 over three clock cycles

    // Sequential logic to update the current state
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= STATE_A;  // Reset to initial state A
        else
            current_state <= next_state;
    end
    
    // Combinational logic for determining next state and outputs
    always_comb begin
        next_state = current_state;  // Default: stay in the current state
        
        z = 0;  // Default: output `z` is 0

        case (current_state)
            STATE_A: begin
                if (s == 1) begin
                    next_state = STATE_B;
                    w_count = 2'b00;  // Reset count when entering B
                end
            end
            
            STATE_B: begin
                if (w == 1) 
                    w_count = w_count + 1;  // Count occurrences of `w` being 1
                
                // After three clock cycles, decide whether to set z and reset the counter
                if (w_count == 2'b11) begin
                    next_state = STATE_B;
                    z = 1;  // Set `z` because w was 1 exactly twice in the last three clocks
                end else if (w_count != 2'b00) begin
                    next_state = STATE_B;
                    z = 0;  // Ensure `z` is set to 0 unless condition met
                end
                
                // After processing, reset or decrement w_count appropriately
                if ((w_count == 2'b11) || (w_count != 2'b00)) begin
                    w_count = (w_count > 0) ? w_count - 1 : 2'b00;
                end
            end

        endcase
    end
    
endmodule

// VERILOG-EVAL: errant inclusion of module definition
