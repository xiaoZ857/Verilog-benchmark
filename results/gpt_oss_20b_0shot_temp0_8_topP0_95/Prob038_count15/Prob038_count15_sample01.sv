
//===================================================================
//  TopModule
//  4‑bit binary counter (0‑15) with synchronous active‑high reset
//===================================================================

module TopModule (
    input  wire        clk,    // Clock (positive‑edge triggered)
    input  wire        reset,  // Synchronous active‑high reset
    output reg  [3:0]  q       // 4‑bit counter output
);

    // On each rising edge of the clock:
    always @(posedge clk) begin
        if (reset)                   // Synchronous reset
            q <= 4'd0;               // Reset counter to 0
        else
            q <= q + 1'b1;           // Increment (wraps automatically to 0 after 15)
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
