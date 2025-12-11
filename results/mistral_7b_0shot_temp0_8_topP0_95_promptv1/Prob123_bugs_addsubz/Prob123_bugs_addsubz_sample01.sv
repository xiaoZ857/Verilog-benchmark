
module TopModule (
  input do_sub,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);
 ```verilog
always @(posedge clk) begin
    if (~do_sub)
        assign out = a + b;
    else
        assign out = a - b;

    if (out == 0)
        result_is_zero <= 1'b1;
    else
        result_is_zero <= 1'b0;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
