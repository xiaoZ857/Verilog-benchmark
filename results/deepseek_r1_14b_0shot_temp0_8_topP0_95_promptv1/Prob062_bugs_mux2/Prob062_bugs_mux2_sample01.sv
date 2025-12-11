
module TopModule (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);
always @(posedge clk or changed sel) begin
    if (~sel)
        out <= a;
    else
        out <= b;
end
endmodule
