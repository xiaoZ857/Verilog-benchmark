
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
assign out = case(sel)
            4'b000 : data0,
            4'b001 : data1,
            4'b010 : data2,
            4'b011 : data3,
            4'b100 : data4,
            4'b101 : data5,
            default : 4'b0;
endmodule
