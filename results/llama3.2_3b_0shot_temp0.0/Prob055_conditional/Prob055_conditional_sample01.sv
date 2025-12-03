

module TopModule (
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  input [7:0] d,
  output reg [7:0] min
);

reg [7:0] min = a;
assign min = min < b ? min : (min < c ? (min < d ? min : d) : (min < c ? c : (min < d ? d : d)));
endmodule
