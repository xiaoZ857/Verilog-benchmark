
// 4‑bit binary counter (0 … 15) with synchronous active‑high reset
module TopModule (
    input  wire        clk,   // clock input
    input  wire        reset, // active‑high synchronous reset
    output reg  [3:0]  q      // 4‑bit counter output
);

    // Synchronous logic: increment or reset on the rising edge of clk
    always @(posedge clk) begin
        if (reset)          // synchronous reset
            q <= 4'd0;      // reset counter to 0
        else
            q <= q + 4'd1;  // increment modulo 16 (wrap‑around automatically)
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
