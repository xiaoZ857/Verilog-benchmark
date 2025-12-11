
module TopModule (
  output zero
);
 ```verilog
always @(posedge clk) begin
    zero = 1'b0;
end
endmodule

// VERILOG-EVAL: abnormal backticks count
