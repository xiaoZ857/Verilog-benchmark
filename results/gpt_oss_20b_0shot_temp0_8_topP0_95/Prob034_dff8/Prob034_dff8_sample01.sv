
// TopModule.v
// 8‑bit D flip‑flop array – all triggered on the rising edge of clk
module TopModule (
    input  wire        clk,   // clock
    input  wire [7:0]  d,     // data input
    output reg  [7:0]  q      // data output (registered)
);

    // On every rising edge of clk, latch the input vector d into q.
    always @(posedge clk) begin
        q <= d;          // non‑blocking assignment for synchronous logic
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
