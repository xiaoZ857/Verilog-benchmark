
// ---------------------------------------------------------------
// 8‑bit register (8 D‑flip‑flops) with active‑high asynchronous reset
// ---------------------------------------------------------------
//  - All FFs are edge‑triggered on the positive edge of `clk`
//  - Asynchronous reset (`areset`) is active high
//  - When reset is asserted, `q` is forced to 8'b0
// ---------------------------------------------------------------

module TopModule (
    input  wire        clk,     // Clock (positive‑edge triggered)
    input  wire [7:0]  d,       // Data input
    input  wire        areset,  // Active‑high asynchronous reset
    output reg  [7:0]  q        // Registered output
);

    // Synchronous behavior with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)          // Asynchronous reset
            q <= 8'b0;       // Reset output to 0
        else
            q <= d;          // Capture data on clock edge
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
