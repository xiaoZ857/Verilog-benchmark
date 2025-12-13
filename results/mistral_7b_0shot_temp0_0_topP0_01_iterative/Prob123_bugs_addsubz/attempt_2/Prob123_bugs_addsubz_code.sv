
module TopModule (
  input do_sub,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);
always @(posedge clk) begin
  if (do_sub)
    out = a - b;
  else
    out = a + b;

  if (out == 0 || (a == b && do_sub))
    result_is_zero = 1;
  else
    result_is_zero = 0;
end

// VERILOG-EVAL: endmodule not found
