
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
 ```verilog
always @* begin
    if (d)
        q = a | (b & !c); // OR gate with c as inverted input
    else
        q = 1'b0;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
