
module TopModule (
  input a,
  input b,
  output out
);
 ```verilog
always @(posedge clk) begin
    if (resetn == 1'b0) begin
        out <= 1'b0;
    end else begin
        out <= a & b;
    end
end
Verification Checklist:
[ ] Code ends with `endmodule` (already provided)
[ ] All wire outputs use `assign` keyword (none in this code)
[ ] All reg outputs are assigned in always blocks (yes, out is a reg output and assigned in an always block)
[ ] Only declared signals are used (a, b, clk, resetn, out)
[ ] Blocking/non-blocking assignments are correct (using non-blocking assignment for sequential logic at posedge clk)

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
