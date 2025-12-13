
// ---------------------------------------------------------------------------
//  TopModule
//  ---------
//  Decade counter (0‑9) with synchronous active‑high reset.
//  The counter increments on every rising edge of clk.
//  When reset is asserted, the counter is set to 0.
// ---------------------------------------------------------------------------

module TopModule (
    input  wire        clk,   // Clock input
    input  wire        reset, // Active‑high synchronous reset
    output reg  [3:0]  q      // 4‑bit counter output
);

    // Synchronous logic
    always @(posedge clk) begin
        if (reset) begin
            // Reset the counter to 0
            q <= 4'd0;
        end
        else if (q == 4'd9) begin
            // Wrap around after reaching 9
            q <= 4'd0;
        end
        else begin
            // Normal counting
            q <= q + 1'b1;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
