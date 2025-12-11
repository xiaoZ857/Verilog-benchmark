
module TopModule (
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);
assign q[98:0] = data[100:2];
assign q[99]   = data[1];

assign q[96:0] = data[98:0];
assign q[97]    = data[99];

always @(posedge clk) begin
    if (load)
        q <= data;
end

assign q[96:1] = ena == 2'b01 ? q[98:0][3:0] : q[100:2][1:0];
assign q[97]     = ena == 2'b01 ? q[99]   : q[101];

assign q[98:4] = ena == 2'b10 ? q[96:0][5:0] : q[98:0][7:2];
assign q[99]    = ena == 2'b10 ? q[97]     : q[99];
assign q[100:6] = ena == 2'b10 ? q[100:2][6:0] : q[102:8][1:0];

assign q[98:4] = data[96:0][5:0] & ena == 2'b01;
assign q[99]    = data[97]     & ena == 2'b01;
assign q[100:6] = data[98]     & ena == 2'b10;

assign q[98:4] = data[96:0][7:2] & ena == 2'b10;
assign q[99]    = data[97]     & ena == 2'b10;
assign q[100:6] = data[98]     & ena == 2'b00;

endmodule
