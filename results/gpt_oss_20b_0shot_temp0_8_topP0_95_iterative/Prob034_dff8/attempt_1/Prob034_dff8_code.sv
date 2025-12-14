
module TopModule (
  input clk,
  input [7:0] d,
  output reg [7:0] q
);
// -----------------------------------------------------------------------------
//  Basic D‑flip‑flop (positive‑edge triggered)
// -----------------------------------------------------------------------------
module DFF (
    input  wire clk,   // Clock
    input  wire d,     // Data input
    output reg  q      // Data output
);
    // On every rising edge of clk, latch the input
    always @(posedge clk) begin
        q <= d;
    end
endmodule


// -----------------------------------------------------------------------------
//  TopModule – 8 independent D‑flip‑flops
// -----------------------------------------------------------------------------
module TopModule (
    input  wire        clk,  // Global clock
    input  wire [7:0]  d,    // 8‑bit data bus
    output wire [7:0]  q     // 8‑bit output bus
);

    // Generate 8 identical DFF instances
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : dff_inst
            DFF u_dff (
                .clk(clk),
                .d (d[i]),
                .q (q[i])
            );
        end
    endgenerate

endmodule

// VERILOG-EVAL: errant inclusion of module definition
