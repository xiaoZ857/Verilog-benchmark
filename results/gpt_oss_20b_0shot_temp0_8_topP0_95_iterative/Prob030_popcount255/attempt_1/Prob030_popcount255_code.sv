
module TopModule (
    input  wire [254:0] in,   // 255‑bit input vector
    output reg  [7:0]   out   // 8‑bit pop‑count result
);

    /* -------------------------------------------------------
       1)  Combinational implementation
       -------------------------------------------------------
       The pop‑count is purely combinational.  We use an
       `always_comb` block so that synthesis tools infer a
       combinational adder tree.  The result is stored in
       a `reg` type (required for a procedural assignment)
       but the logic is still purely combinational – no clock
       edge is needed.
    */
    always_comb begin
        // Initialise the accumulator
        out = 8'd0;

        // Accumulate the value of each bit.
        // 255 additions – the synthesiser will collapse this
        // into an efficient adder‑tree (or use the built‑in
        // popcount primitive if available).
        for (int i = 0; i < 255; i = i + 1) begin
            out = out + in[i];
        end
    end

    /* -------------------------------------------------------
       2)  Optional – use SystemVerilog $countones if supported
       -------------------------------------------------------
       If the synthesis tool understands the SystemVerilog
       $countones built‑in, the above loop can be replaced by
       a single assignment.  Uncomment the following lines
       and comment out the always_comb block above

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
