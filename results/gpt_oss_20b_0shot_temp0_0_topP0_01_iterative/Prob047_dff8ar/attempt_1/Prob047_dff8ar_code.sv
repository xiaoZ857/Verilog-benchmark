
// 8‑bit register with active‑high asynchronous reset
// All bits are updated on the rising edge of clk.
// When areset is asserted, the register is cleared to 0 immediately
// (i.e., asynchronously).

module TopModule (
    input  wire        clk,     // synchronous clock
    input  wire [7:0]  d,       // data input
    input  wire        areset,  // active‑high asynchronous reset
    output reg  [7:0]  q        // registered output
);

    // Asynchronous reset + synchronous data capture
    always @(posedge clk or posedge areset) begin
        if (areset)          // asynchronous reset
            q <= 8'b0;       // reset output to zero
        else
            q <= d;          // capture data on rising edge of clk
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
