
module TopModule (
    input  wire clk,      // system clock
    input  wire j,        // input used in OFF state
    input  wire k,        // input used in ON  state
    input  wire areset,   // async active‑high reset
    output wire out       // Moore output
);

    // ------------------------------------------------------------------
    // State encoding
    // ------------------------------------------------------------------
    localparam OFF = 1'b0;
    localparam ON  = 1'b1;

    // ------------------------------------------------------------------
    // State register (synchronous update, async reset)
    // ------------------------------------------------------------------
    reg state;           // current state

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
