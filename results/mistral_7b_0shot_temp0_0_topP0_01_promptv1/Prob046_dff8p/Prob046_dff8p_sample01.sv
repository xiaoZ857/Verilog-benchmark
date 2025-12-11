
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
 ```verilog
always @(negedge clk) begin
    if (reset)
        q <= 8'b01_0101_0101; // 0x34 in binary
    else
        q <= d;
end
endmodule

// VERILOG-EVAL: abnormal backticks count
