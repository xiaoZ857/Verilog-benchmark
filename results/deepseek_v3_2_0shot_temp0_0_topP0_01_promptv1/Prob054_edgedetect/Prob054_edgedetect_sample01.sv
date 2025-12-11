
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);
always @(posedge clk) begin
    reg [7:0] in_prev;
    in_prev <= in;
    pedge <= in & ~in_prev;
end
endmodule
