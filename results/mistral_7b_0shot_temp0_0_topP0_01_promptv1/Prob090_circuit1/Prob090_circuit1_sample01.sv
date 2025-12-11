
module TopModule (
  input a,
  input b,
  output q
);
 ```verilog
always @* begin
    if (a == b)
        q = 1'b1;
    else
        q = 1'b0;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
