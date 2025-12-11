
module TopModule (
  input x,
  input y,
  output z
);
 ```verilog
always @(posedge clk) begin
    assign z = (x ^ y) & x;
end
endmodule

// VERILOG-EVAL: abnormal backticks count
