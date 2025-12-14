
//====================================================================
//  Two‑bit saturating counter with asynchronous positive‑edge reset
//====================================================================
//  - state[1:0]  : two‑bit counter value
//  - areset      : async reset, active‑high, resets to 2'b01
//  - train_valid : training enable (must be 1 to change the counter)
//  - train_taken : determines increment (1) or decrement (0)
//  - clk         : synchronous clock
//--------------------------------------------------------------------
module TopModule (
    input  logic        clk,          // system clock
    input  logic        areset,       // asynchronous active‑high reset
    input  logic        train_valid,  // training enable
    input  logic        train_taken,  // training outcome
    output logic [1:0]  state         // two‑bit counter output
);

    // Register that holds the counter value
    // (output logic is assigned inside the always_ff)
    logic [1:0] state_reg;

    // Asynchronous reset + synchronous update
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to “weakly not‑taken” (binary 01)
            state_reg <= 2'b01;
        end else if (train_valid) begin
            if (train_taken) begin
                // Increment, saturate at 3 (binary 11)
                if (state_reg != 2'b11)
                    state_reg <= state_reg + 1'b1;
            end else begin
                // Decrement, saturate at 0 (binary 00)
                if (state_reg != 2'b00)
                    state_reg <= state_reg - 1'b1;
            end
        end
        // If train_valid == 0, keep the current value (no assignment needed)
    end

    // Drive the output
    assign state = state_reg;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
