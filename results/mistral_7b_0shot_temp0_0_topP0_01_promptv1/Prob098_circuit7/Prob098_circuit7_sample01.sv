
module TopModule (
  input clk,
  input a,
  output reg q
);
 ```verilog
always @(posedge clk) begin
    if (a)
        q <= ~q;
    else
        q <= 1'b0;
end
endmodule

// VERILOG-EVAL: abnormal backticks count
