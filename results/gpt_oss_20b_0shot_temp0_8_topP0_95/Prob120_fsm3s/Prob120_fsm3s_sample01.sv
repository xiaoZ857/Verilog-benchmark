
module TopModule (
    input  wire clk,     // Positive‑edge clock
    input  wire in,      // Single input
    input  wire reset,   // Active‑high synchronous reset
    output wire out      // Single output
);

    // ----------------------------------------------------------
    // State encoding – use localparams to give each state a
    // unique binary code.  The encoding is arbitrary as long as
    // it is consistent between the state register and the
    // combinational logic.
    // ----------------------------------------------------------
    localparam  STATE_A = 2'b00,
                STATE_B = 2'b01,
                STATE_C = 2'b10,
                STATE_D = 2'b11;

    // ----------------------------------------------------------
    // State register (synchronous)
    // ----------------------------------------------------------
    reg [1:0] state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_A;           // Reset to state A
        end else begin
            state <= next_state;        // Move to next state
        end
    end

    // ----------------------------------------------------------
    // Next‑state logic (combinational)
    // ----------------------------------------------------------
    always @(*) begin
        case (state)
            STATE_A: begin
                if (in == 1'b0) next_state = STATE_A;
                else            next_state = STATE_B;
            end
            STATE_B: begin
                if (in == 1'b0) next_state = STATE_C;
                else            next_state = STATE_B;
            end
            STATE_C: begin
                if (in == 1'b0) next_state = STATE_A;
                else            next_state = STATE_D;
            end
            STATE_D: begin
                if (in == 1'b0) next_state = STATE_C;
                else            next_state = STATE_B;
            end
            default: begin
                // This branch is only for simulation safety.
                // In synthesis, the default should never be hit.
                next_state = STATE_A;
            end
        endcase
    end

    // ----------------------------------------------------------
    // Output logic (Moore – depends only on current state)
    // ------------------------------------------------

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
