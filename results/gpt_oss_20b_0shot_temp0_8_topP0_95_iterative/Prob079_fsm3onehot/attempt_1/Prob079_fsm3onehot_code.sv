
module TopModule (
    input                 in,        // 1‑bit data input
    input  [3:0]          state,     // current state (one‑hot)
    output reg [3:0]      next_state,// next state (one‑hot)
    output                out        // Moore output
);

    // --------------------------------------------------------------
    // 1.  Output logic  (Moore → depends only on current state)
    // --------------------------------------------------------------
    //   A = 4'b0001  → out = 0
    //   B = 4'b0010  → out = 0
    //   C = 4'b0100  → out = 0
    //   D = 4'b1000  → out = 1
    //
    //  Since the encoding is one‑hot, the MSB (bit 3) is high only in state D
    assign out = state[3];

    // --------------------------------------------------------------
    // 2.  State‑transition logic  (combinational)
    // --------------------------------------------------------------
    always @(*) begin
        // Default assignment (safe for synthesis)
        next_state = 4'b0000;

        case (state)
            4'b0001: // State A
                next_state = in ? 4'b0010 : 4'b0001;   // 0→A, 1→B
            4'b0010: //

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
