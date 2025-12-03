

module TopModule (
  input [255:0] in,
  input [7:0] sel,
  output  out
);

assign out = in[(sel * 8): (sel * 8 + 7)];
endmodule
