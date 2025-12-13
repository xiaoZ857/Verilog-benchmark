
// TopModule.v
// Simple D‑flip‑flop (positive‑edge triggered)
//   clk : clock input (positive edge)
//   d   : data input
//   q   : registered output

module TopModule (
    input  wire clk,   // clock
    input  wire d,     // data input
    output reg  q      // registered output
);

    // Positive‑edge triggered D‑FF
    always @(posedge clk) begin
        q <= d;          // non‑blocking assignment
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
