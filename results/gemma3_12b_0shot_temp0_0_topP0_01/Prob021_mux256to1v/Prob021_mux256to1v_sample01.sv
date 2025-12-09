

module TopModule (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

always @(sel) begin
  out = in[sel * 4 : sel * 4 + 3];
end
endmodule
