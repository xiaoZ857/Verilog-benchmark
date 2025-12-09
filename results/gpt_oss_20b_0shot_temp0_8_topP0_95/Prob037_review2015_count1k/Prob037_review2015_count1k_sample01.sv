
// TopModule.v
// ---------------
// 10‑bit counter that counts 0 … 999 (period = 1000 clock cycles)
// Synchronous active‑high reset that forces the counter back to 0
// All signals are positive‑edge triggered.

module TopModule (
    input  wire        clk,   // Clock input
    input  wire        reset, // Synchronous active‑high reset
    output reg  [9:0]  q      // 10‑bit counter output
);

    // Positive‑edge triggered counter
    always @(posedge clk) begin
        if (reset)                // Synchronous reset
            q <= 10'd0;
        else if (q == 10'd999)    // Wrap‑around at 999
            q <= 10'd0;
        else                      // Normal counting
            q <= q + 10'd1;
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
