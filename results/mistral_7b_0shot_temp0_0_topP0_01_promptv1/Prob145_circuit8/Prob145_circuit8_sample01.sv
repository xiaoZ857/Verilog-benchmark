
module TopModule (
  input clock,
  input a,
  output reg p,
  output reg q
);
 ```verilog
always @(posedge clk) begin
    if (a)
        p <= ~p;
    else
        p <= 0;

    if (a && !p)
        q <= ~q;
    else if (!a && p)
        q <= ~q;
    else
        q <= 0;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
