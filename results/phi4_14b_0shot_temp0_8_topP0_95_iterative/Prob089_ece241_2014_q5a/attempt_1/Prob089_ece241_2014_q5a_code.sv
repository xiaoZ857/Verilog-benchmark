
module TopModule (
    input clk,
    input areset,      // Asynchronous reset
    input x,           // Serial input bit (least significant bit first)
    output reg z       // Serial output bit
);

    // Define states for the Moore machine
    typedef enum logic [1:0] {
        IDLE,          // Waiting for conversion to start
        FLIP_AND_PASS  // Inverting bits until first '1' is found
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic for Moore machine
    always_comb begin
        case (current_state)
            IDLE: z = 1'b0;   // Default output in IDLE state
            FLIP_AND_PASS: z = ~x; // Flip the bit until first '1'
            default: z = 1'bx;
        endcase
    end

    // State transition logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (~areset) next_state = FLIP_AND_PASS;
                else next_state = IDLE; // Stay in IDLE if reset is asserted
            end
            
            FLIP_AND_PASS: begin
                if (x == 1'b0) next_state = FLIP_AND_PASS;
                else next_state = IDLE; // Transition to IDLE after first '1'
            end
            
            default: next_state = IDLE;
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
