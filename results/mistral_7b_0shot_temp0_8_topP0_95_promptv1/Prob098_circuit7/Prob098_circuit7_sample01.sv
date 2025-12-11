
module TopModule (
  input clk,
  input a,
  output reg q
);
 ```verilog
always @(posedge clk)
begin
    if (a)
        q <= (q ^= 1'b1); // XOR with constant 1
    else
        q <= q; // no change
end
endmodule

// VERILOG-EVAL: abnormal backticks count
