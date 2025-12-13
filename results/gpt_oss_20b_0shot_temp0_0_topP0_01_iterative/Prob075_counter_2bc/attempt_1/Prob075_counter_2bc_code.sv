
//=====================================================================
//  Two‑bit saturating counter
//
//  Behaviour:
//    * When train_valid = 1 and train_taken = 1  →  counter increments
//      (but never goes above 3).
//    * When train_valid = 1 and train_taken = 0  →  counter decrements
//      (but never goes below 0).
//    * When train_valid = 0                     →  counter holds its value.
//    * Asynchronous positive‑edge reset (areset) sets the counter to
//      the “weakly not‑taken” value 2'b01.
//
//  Output:
//    state[1:0] – current counter value.
//=====================================================================

module TopModule (
    input  logic clk,          // System clock
    input  logic areset,       // Asynchronous reset (positive‑edge)
    input  logic train_valid,  // Training enable
    input  logic train_taken,  // Training outcome
    output logic [1:0] state   // Two‑bit saturating counter
);

    // ------------------------------------------------------------------
    //  Sequential logic: counter update
    // ------------------------------------------------------------------
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to weakly not‑taken (2'b01)
            state <= 2'b01;
        end else if (train_valid) begin
            // Training active – decide whether to increment or decrement
            if (train_taken) begin
                // Increment with saturation at 3
                if (state == 2'b11)
                    state <= 2'b11;          // already at max
                else
                    state <= state + 1'b1;   // increment
            end else begin
                // Decrement with saturation at 0
                if (state == 2'b00)
                    state <= 2'b00;          // already at min
                else
                    state <= state - 1'b1;   // decrement
            end
        end
        // else: train_valid == 0 → hold current state (no assignment needed)
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
