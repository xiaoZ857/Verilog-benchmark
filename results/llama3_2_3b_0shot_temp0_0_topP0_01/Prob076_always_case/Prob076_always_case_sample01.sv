

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

// Select the corresponding data input based on the sel value
reg [3:0] temp;

assign temp = (sel <= 5) ? 0 : (sel[1:0]);
assign out = (temp == 0) ? data0 : 
               (temp == 1) ? data1 : 
               (temp == 2) ? data2 : 
               (temp == 3) ? data3 : 
               (temp == 4) ? data4 : data5;

// VERILOG-EVAL: endmodule not found
