
module TopModule (
  input [3:0] in,
  output reg [1:0] pos
);
assign pos = $signed(in[2]);
assign pos[1] = !in[2];

assign pos[0] = in[1]; 

endmodule
