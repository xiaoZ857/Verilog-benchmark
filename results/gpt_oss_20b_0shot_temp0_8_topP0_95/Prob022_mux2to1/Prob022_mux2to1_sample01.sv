
// ------------------------------------------------------------
// 1‑bit 2‑to‑1 Multiplexer
//   sel = 0 → out = a
//   sel = 1 → out = b
// ------------------------------------------------------------
module TopModule (
    input  wire a,      // First input
    input  wire b,      // Second input
    input  wire sel,    // Select signal
    output wire out     // Selected output
);

// Combinational assignment (no clock required)
assign out = sel ? b : a;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
