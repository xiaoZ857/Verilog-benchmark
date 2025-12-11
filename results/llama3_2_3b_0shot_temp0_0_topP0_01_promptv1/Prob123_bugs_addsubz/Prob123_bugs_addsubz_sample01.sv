
module TopModule (
  input do_sub,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);
assign out = a + b;
assign result_is_zero = ~out;

if (do_sub)
    if (~out)
        result_is_zero = 1'b1;
else
    out = a - b;

// VERILOG-EVAL: endmodule not found
