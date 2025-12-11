
module TopModule (
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output [5:0] out_not
);
assign out_or_bitwise = a | b;
assign out_or_logical = a & b;

always @(posedge clk) begin
    assign out_not[4:3] = ~b;
    assign out_not[2:1] = ~a;
endmodule
