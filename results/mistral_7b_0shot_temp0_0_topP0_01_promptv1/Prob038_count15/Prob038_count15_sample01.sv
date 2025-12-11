
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
 ```verilog
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 4'b0000;
    else if (clk)
        q <= {q[3], q[2]+1, q[1]+1, q[0]+1};
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
