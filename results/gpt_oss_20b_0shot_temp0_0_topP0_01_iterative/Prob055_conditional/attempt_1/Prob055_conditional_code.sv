
// ------------------------------------------------------------
//  TopModule : Find the minimum of four unsigned 8‑bit numbers
// ------------------------------------------------------------
module TopModule (
    input  wire [7:0] a,      // first operand
    input  wire [7:0] b,      // second operand
    input  wire [7:0] c,      // third operand
    input  wire [7:0] d,      // fourth operand
    output reg  [7:0] min     // smallest of the four
);

    // Combinational logic – no clock required
    always @(*) begin
        // Start with a as the provisional minimum
        min = a;

        // Compare with b
        if (b < min) min = b;

        // Compare with c
        if (c < min) min = c;

        // Compare with d
        if (d < min) min = d;
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
