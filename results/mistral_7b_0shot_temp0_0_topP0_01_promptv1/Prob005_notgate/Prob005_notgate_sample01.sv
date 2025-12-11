
module TopModule (
  input in,
  output out
);
 ```verilog
always @(posedge clk) begin
    out <= !in;
end
endmodule

// VERILOG-EVAL: abnormal backticks count
