
module TopModule (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);
// 8‑bit 2‑to‑1 multiplexer
module top_module (
    input          sel,   // select line
    input  [7:0]   a,     // input A
    input  [7:0]   b,     // input B
    output [7:0]   out    // 8‑bit output
);

    // Continuous assignment – combinational logic
    assign out = sel ? b : a;   // equivalent to (~sel & a) | (sel & b)

endmodule

// VERILOG-EVAL: abnormal backticks count
