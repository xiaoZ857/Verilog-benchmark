
// Decade counter (0 … 9) with pause and synchronous reset
module TopModule (
    input  wire        clk,     // System clock
    input  wire        slowena, // When high, the counter should step
    input  wire        reset,   // Active‑high synchronous reset
    output reg  [3:0]  q        // 4‑bit counter output
);

    // Synchronous logic: executed on the rising edge of clk
    always @(posedge clk) begin
        if (reset) begin
            // Reset the counter to 0
            q <= 4'd0;
        end else if (slowena) begin
            // Increment only if slowena is asserted
            if (q == 4'd9) begin
                // Wrap back to 0 after reaching 9
                q <= 4'd0;
            end else begin
                // Normal increment
                q <= q + 1'b1;
            end
        end
        // When slowena is low, the counter holds its value automatically
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
