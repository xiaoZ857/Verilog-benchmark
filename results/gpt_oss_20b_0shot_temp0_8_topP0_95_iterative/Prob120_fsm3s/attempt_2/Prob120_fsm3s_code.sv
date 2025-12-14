
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);
    // -------------------------------------------------------------
    //  State encoding
    // -------------------------------------------------------------
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    // Current state register
    state_t state, next_state;

    // -------------------------------------------------------------
    //  State register – synchronous with active‑high reset
    // -------------------------------------------------------------
    always_ff @(posedge clk) begin
        if (reset)
            state <= STATE_A;          // reset to A
        else
            state <= next_state;       // normal state transition
    end

    // -------------------------------------------------------------
    //  Next‑state logic (combinational)
    // -------------------------------------------------------------
    always_comb begin
        // Default: stay in current state (safety)
        next_state = state;

        // Choose next state based on current state and input
        case (state)
            STATE_A: next_state = (in == 1'b0) ? state_t'(STATE_A) : state_t'(STATE_B);
            STATE_B: next_state = (in == 1'b0) ? state_t'(STATE_C) : state_t'(STATE_B);
            STATE_C: next_state = (in == 1'b0) ? state_t'(STATE_A) : state_t'(

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
