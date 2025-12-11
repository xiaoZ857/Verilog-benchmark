
module TopModule (
  input a,
  input b,
  input c,
  output out
);
 ```verilog
always @(posedge clk) begin
    if (c)
        out <= ~(a & b);
    else
        out <= a ^ b;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
