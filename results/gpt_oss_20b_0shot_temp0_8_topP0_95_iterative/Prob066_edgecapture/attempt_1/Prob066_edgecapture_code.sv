
// -----------------------------------------------------------------------------
// Module:  TopModule
// Purpose: For each bit of the 32‑bit input vector, capture a falling edge
//          (1 → 0).  Once captured the corresponding bit of the output
//          remains 1 until a synchronous active‑high reset clears it.
// -----------------------------------------------------------------------------
module TopModule (
    input  wire        clk,      // clock (positive edge)
    input  wire        reset,    // synchronous active‑high reset
    input  wire [31:0] in,       // 32‑bit input vector
    output reg  [31:0] out       // 32‑bit output vector
);

    // Register to hold the previous value of the input vector
    reg [31:0] prev_in;

    always @(posedge clk) begin
        if (reset) begin
            out      <= 32'b0;   // clear all bits
            prev_in  <= 32'b0;   // reset previous value (optional)
        end else begin
            // Detect falling edges: previous = 1, current = 0
            // (~in) & prev_in == 1 when the transition 1 → 0 occurs
            out <= out | (prev_in & ~in);
            prev_in <= in;      // store current input for next cycle
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
