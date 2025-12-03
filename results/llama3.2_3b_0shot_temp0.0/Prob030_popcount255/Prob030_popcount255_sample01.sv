

module TopModule (
  input [254:0] in,
  output reg [7:0] out
);

reg [7:0] out;

always @(*) begin
  out = $count_mod(in[0]);
endmodule
