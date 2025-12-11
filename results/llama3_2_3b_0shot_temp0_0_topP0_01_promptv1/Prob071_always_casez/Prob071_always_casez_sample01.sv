
module TopModule (
  input [7:0] in,
  output reg [2:0] pos
);
assign pos = {in[6], in[5], in[4]};
endmodule
