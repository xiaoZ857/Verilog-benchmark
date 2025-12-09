
// ------------------------------------------------------------
// 256‑to‑1 Multiplexer (combinational)
// ------------------------------------------------------------
//  • 256 1‑bit inputs packed into a 256‑bit vector `in`
//  • 8‑bit select input `sel`
//  • 1‑bit output `out`
//  • No clock needed – the module is combinational
// ------------------------------------------------------------

module TopModule (
    input  wire [255:0] in,   // 256 packed inputs
    input  wire [7:0]   sel,  // 8‑bit selector (0‑255)
    output wire         out   // selected output bit
);

    // Combinational assignment – simply index the vector
    assign out = in[sel];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
