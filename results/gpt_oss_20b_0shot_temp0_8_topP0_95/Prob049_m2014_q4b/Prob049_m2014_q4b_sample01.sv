
//=====================================================================
//  TopModule
//  ---------
//  Positive‑edge‑triggered D‑flip‑flop with asynchronous reset
//  (reset is active‑high).
//
//  Ports:
//    clk  – main clock (posedge)
//    d    – data input
//    ar   – asynchronous reset (active‑high)
//    q    – output (registered)
//=====================================================================
module TopModule (
    input  logic clk,   // clock input
    input  logic d,     // data input
    input  logic ar,    // async reset (active‑high)
    output logic q      // registered output
);

    // Use an always_ff block: synchronous logic with async reset
    always_ff @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= 1'b0;   // asynchronous reset to 0
        end else begin
            q <= d;      // capture d on clock edge
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
