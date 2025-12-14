
module TopModule (
    input  wire clk,     // system clock
    input  wire in,      // input to the FSM
    input  wire areset,  // asynchronous active‑high reset
    output reg  out      // Moore output (0 = A, 1 = B)
);

    // State encoding
    localparam STATE_A = 1'b0;
    localparam STATE_B = 1'b1;

    // Current state register
    reg state;
    // Next state combinational signal
    reg next_state;

    // ------------------------------------------------------------------
    // State register – synchronous update, asynchronous reset
    // ------------------------------------------------------------------
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
