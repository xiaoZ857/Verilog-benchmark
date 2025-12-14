
//-----------------------------------------------------------------------------
//  TopModule
//  • 8 independent D‑flip‑flops
//  • Active‑high asynchronous reset (output set to 0)
//  • All FFs triggered on the positive edge of *clk*
//-----------------------------------------------------------------------------
module TopModule (
    input  wire        clk,     // Clock input (positive edge)
    input  wire [7:0]  d,       // 8‑bit data input
    input  wire        areset,  // Active‑high asynchronous reset
    output reg  [7:0]  q        // 8‑bit data output
);

    // Asynchronous reset + synchronous data capture
    always @(posedge clk or posedge areset) begin
        if (areset)                // Asynchronous reset
            q <= 8'b0;             // Reset output to 0
        else
            q <= d;                // Capture input on clock edge
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
