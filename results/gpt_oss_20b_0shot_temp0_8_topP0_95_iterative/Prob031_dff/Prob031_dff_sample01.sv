
// ---------------------------------------------------------------
//  TopModule: Simple D‑Flip‑Flop
//  - Positive‑edge triggered on 'clk'
//  - Data input: 'd'
//  - Data output: 'q' (registered)
// ---------------------------------------------------------------
module TopModule (
    input  wire  clk,   // Clock input
    input  wire  d,     // Data input
    output reg   q      // Registered output
);

    // Capture 'd' on the rising edge of 'clk'
    always @(posedge clk) begin
        q <= d;
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
