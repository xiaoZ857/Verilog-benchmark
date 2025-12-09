
module TopModule (
  input do_sub,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);
// --------------------------------------------------
// Adder‑subtractor with correct zero‑flag logic
// --------------------------------------------------
module top_module (
    input  wire        do_sub,          // 0 → add, 1 → subtract
    input  wire [7:0]  a,
    input  wire [7:0]  b,
    output reg  [7:0]  out,
    output reg         result_is_zero   // 1 if out == 0
);

    // Combinational logic – use blocking assignments
    always @(*) begin
        // Perform add or subtract
        out = do_sub ? (a - b) : (a + b);

        // Correct zero‑flag detection
        // (out == 8'b0) is true only when the entire vector is zero
        result_is_zero = (out == 8'b0);
    end

endmodule
