
//  D‑flip‑flop with active‑high synchronous reset
//  Reset output is forced to logic 0 when r is high on the rising edge of clk.
module TopModule (
    input  logic clk,   // positive‑edge clock
    input  logic d,     // data input
    input  logic r,     // synchronous reset (active high)
    output logic q      // registered output
);

    // Register with synchronous reset
    always_ff @(posedge clk) begin
        if (r) 
            q <= 1'b0;   // reset to zero
        else
            q <= d;      // normal D‑FF operation
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
