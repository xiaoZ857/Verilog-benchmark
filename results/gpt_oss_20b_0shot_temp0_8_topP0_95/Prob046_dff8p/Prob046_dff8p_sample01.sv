
// 8‑bit register made of 8 D‑flip‑flops
// • Active‑high synchronous reset
// • Reset value = 0x34 (00110100b)
// • Triggered on the negative edge of clk
module TopModule (
    input        clk,      // system clock
    input  [7:0] d,        // data input
    input        reset,    // active‑high synchronous reset
    output reg [7:0] q     // stored data
);

    // Negative‑edge triggered D‑FFs with synchronous reset
    always @(negedge clk) begin
        if (reset) begin
            q <= 8'h34;   // reset to 0x34
        end
        else begin
            q <= d;       // normal data transfer
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
