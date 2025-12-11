
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out
);
 ```verilog
always @(posedge clk or negedge {a,b,c,d}) begin
    out <= (~a & ~b) | (~a & c) | (a & b) | (a & ~c);
end
endmodule

// VERILOG-EVAL: abnormal backticks count
