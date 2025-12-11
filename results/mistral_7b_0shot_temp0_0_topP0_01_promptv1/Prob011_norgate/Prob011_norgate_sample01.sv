
module TopModule (
  input a,
  input b,
  output out
);
 ```verilog
always @(posedge clk) begin
    assign out = ~(a | b);
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
