
module TopModule (
  input clk,
  input a,
  input b,
  output out_assign,
  output reg out_always_comb,
  output reg out_always_ff
);
always @(posedge clk) begin
    if(a ^ b)
        out_always_ff <= 1;
    else
        out_always_ff <= 0;
end

// VERILOG-EVAL: abnormal backticks count
