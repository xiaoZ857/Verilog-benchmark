
module TopModule (
    input  wire clk,      // normal clock
    input  wire aresetn,  // asynchronous active‑low reset
    input  wire x,        // data input
    output reg  z         // sequence‑detected flag
);

    /* ----------  State encoding  ---------- */
    localparam  S0 = 2'b00,   // waiting for the first ‘1’
                S1 = 2'b01,   // have seen a ‘1’
                S2 = 2'b10;   // have seen “10”

    reg [1:0] state

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
