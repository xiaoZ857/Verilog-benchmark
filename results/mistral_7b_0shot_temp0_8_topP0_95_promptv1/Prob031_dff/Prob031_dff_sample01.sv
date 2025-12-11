
module TopModule (
  input clk,
  input d,
  output reg q
);
 ```verilog
always @(posedge clk) begin
    if (reset)
        q <= 1'b0;
    else
        q <= d;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
