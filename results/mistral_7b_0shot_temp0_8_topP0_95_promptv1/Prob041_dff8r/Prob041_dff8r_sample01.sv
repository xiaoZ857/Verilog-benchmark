
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
 ```verilog
always @(posedge clk) begin
    if (reset)
        q <= 8'b0;
    else
        q <= d;
end
endmodule

// VERILOG-EVAL: abnormal backticks count
