

module TopModule (
  input [3:0] in,
  output reg [1:0] pos
);

assign pos = {in[2], in[1]};
endmodule
