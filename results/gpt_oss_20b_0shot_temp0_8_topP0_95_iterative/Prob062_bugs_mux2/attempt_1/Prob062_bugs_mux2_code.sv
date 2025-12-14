
module TopModule (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);
// 8‑bit 2‑to‑1 multiplexer – continuous‑assignment style
module top_module (
    input          sel,      // 1‑bit select
    input  [7:0]   a,        // 8‑bit data input A
    input  [7:0]   b,        // 8‑bit data input B
    output [7:0]   out       // 8‑bit data output
);

    // The expression below works for any vector width:
    //  (~sel & a)  : when sel=0 → a is passed through
    //  (sel  & b)  : when sel=1 → b is passed through
    assign out = (~sel & a) | (sel & b);

endmodule
