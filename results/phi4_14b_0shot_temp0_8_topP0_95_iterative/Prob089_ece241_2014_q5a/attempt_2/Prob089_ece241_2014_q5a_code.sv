
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);
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
        PASS_THROUGH: z = x; // Pass through all subsequent bits unchanged
        default: z = 1'bx;
    endcase
end

// State transition logic
always_comb begin
    case (current_state)
        IDLE: next_state = (~areset) ? FLIP_AND_PASS : IDLE;

        FLIP_AND_PASS: next_state = (x == 1'b0) ? FLIP_AND_PASS : PASS_THROUGH;
        
        PASS_THROUGH: next_state = areset ? IDLE : PASS_THROUGH; // Remain in pass-through until reset

        default: next_state = IDLE;
    endcase
end

// Define states for the Moore machine including a new state for passing through bits after encountering '1'
typedef enum logic [1:0] {
    IDLE,          // Waiting for conversion to start
    FLIP_AND_PASS, // Inverting bits until first '1' is found
    PASS_THROUGH   // Passing bits unchanged after first '1'
} state_t;

// VERILOG-EVAL: endmodule not found
