
// ---------------------------------------------------------------
//  2‑1 Multiplexer (100‑bit wide)
//  When sel = 0 → output = a
//  When sel = 1 → output = b
// ---------------------------------------------------------------

module TopModule (
    input  wire [99:0] a,   // Data input A (100‑bit)
    input  wire [99:0] b,   // Data input B (100‑bit)
    input  wire        sel, // Select signal
    output wire [99:0] out  // Multiplexed output
);

    // Combinational logic – no clock required
    assign out = sel ? b : a;

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
