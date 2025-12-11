
module TopModule (
  input clk,
  input j,
  input k,
  output reg Q
);
 ```verilog
always @(posedge clk) begin
    if (j & ~k)
        Q <= Qold;
    else if (~j & k)
        Q <= 0;
    else if (j & k)
        Q <= 1;
    else
        Q <= ~Qold;
end

assign Qold = Q;

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
