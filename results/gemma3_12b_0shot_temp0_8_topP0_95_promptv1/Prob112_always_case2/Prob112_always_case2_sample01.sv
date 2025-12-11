
module TopModule (
  input [3:0] in,
  output reg [1:0] pos
);
assign pos = in[3] ? 3'b111 :
            in[2] ? 3'b110 :
            in[1] ? 3'b101 :
            in[0] ? 3'b100 : 3'b000;
endmodule
