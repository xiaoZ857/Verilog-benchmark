
// TopModule.v
// Reverses the bit ordering of a 100‑bit vector.
// out[0]  = in[99]
// out[1]  = in[98]
// ...
// out[99] = in[0]

module TopModule (
    input  wire [99:0] in,   // 100‑bit input
    output reg  [99:0] out   // 100‑bit output (reversed)
);

    integer i;               // loop index

    // Combinational logic – no clock required
    always @* begin
        for (i = 0; i < 100; i = i + 1) begin
            out[i] = in[99 - i];
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
