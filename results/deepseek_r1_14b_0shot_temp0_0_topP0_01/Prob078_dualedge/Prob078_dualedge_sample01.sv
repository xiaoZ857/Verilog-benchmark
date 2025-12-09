

module TopModule (
  input clk,
  input d,
  output reg q
);

always @(posedge clk)
    q1 <= d;

always @(negedge clk)
    q2 <= d;

always @*
    q = q1 | q2;

// VERILOG-EVAL: endmodule not found
