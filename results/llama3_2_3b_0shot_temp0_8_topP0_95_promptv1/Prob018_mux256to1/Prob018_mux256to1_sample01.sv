
module TopModule (
  input [255:0] in,
  input [7:0] sel,
  output  out
);
assign out = {in[sel*8+7 : sel*8], in[sel*8+6 : sel*8+1]};

endmodule
