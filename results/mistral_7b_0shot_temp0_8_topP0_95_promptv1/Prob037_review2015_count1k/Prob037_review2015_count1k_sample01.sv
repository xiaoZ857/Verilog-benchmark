
module TopModule (
  input clk,
  input reset,
  output reg [9:0] q
);
 ```verilog
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 10h;
    else
        if (q < 999)
            q <= {q[8], q[7]+1, q[6], q[5], q[4], q[3], q[2], q[1], q[0]+1};
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
