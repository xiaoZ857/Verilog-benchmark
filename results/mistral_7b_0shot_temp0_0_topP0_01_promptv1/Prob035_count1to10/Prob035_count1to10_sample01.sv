
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
 ```verilog
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 4'b0001;
    else if (q < 9)
        q <= q + 1;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
