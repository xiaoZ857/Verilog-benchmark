
// TopModule.v
// Simple D flip‑flop – q captures d on the rising edge of clk
module TopModule (
    input  wire  clk,   // clock input
    input  wire  d,     // data input
    output reg   q      // data output (register)
);

    // Capture the input on the positive edge of the clock
    always @(posedge clk) begin
        q <= d;
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
