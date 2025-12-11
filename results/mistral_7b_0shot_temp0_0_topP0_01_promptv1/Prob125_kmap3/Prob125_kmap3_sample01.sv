
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);
 ```verilog
always @(posedge c) begin
    if (d)
        out <= a ^ b;
    else
        out <= a & ~b;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
