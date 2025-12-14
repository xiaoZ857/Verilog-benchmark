
// TopModule.v
// -------------
// A simple D‑flip‑flop whose D input is the XOR of the external
// stimulus 'in' and the flip‑flop's own output 'out'.
// The flip‑flop is clock‑synchronous (positive‑edge triggered)
// and has no reset.
module TopModule (
    input  logic clk,   // clock input (positive edge)
    input  logic in,    // external data input
    output logic out    // flip‑flop output
);

    // Positive‑edge triggered D‑FF with feedback
    // `out` on the RHS is the *current* value of the output
    // (i.e. the value before the clock edge).
    always_ff @(posedge clk) begin
        out <= in ^ out;   // D = in XOR out
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
