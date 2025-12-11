
module TopModule (
  input [2:0] sel,
  input [3:0] data0,
  input [3:0] data1,
  input [3:0] data2,
  input [3:0] data3,
  input [3:0] data4,
  input [3:0] data5,
  output reg [3:0] out
);
 ```verilog
always @(posedge clk) begin
    if (sel < 6 && sel >= 0)
        out = {data{sel}};
    else
        out <= 4'b0;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
