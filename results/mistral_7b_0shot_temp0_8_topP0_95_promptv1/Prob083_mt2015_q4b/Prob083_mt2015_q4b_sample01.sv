
module TopModule (
  input x,
  input y,
  output z
);
 ```verilog
assign z = ~(x & y);

always @(posedge clk) begin
    if (~reset)
        z <= ~(x & y);
end
endmodule

// VERILOG-EVAL: abnormal backticks count
