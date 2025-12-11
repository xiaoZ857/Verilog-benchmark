
module TopModule (
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q
);
assign q = d & (byteena == 2'b01) ? d[15:8] : d[7:0];
endmodule
