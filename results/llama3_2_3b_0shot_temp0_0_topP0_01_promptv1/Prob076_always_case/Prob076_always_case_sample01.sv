
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
assign out = sel[2] ? data5 : sel[1] ? data4 : sel[0] ? data3 : sel[1] ? data2 : sel[0] ? data1 : sel[1] ? data0 : 4'b0;

// VERILOG-EVAL: endmodule not found
