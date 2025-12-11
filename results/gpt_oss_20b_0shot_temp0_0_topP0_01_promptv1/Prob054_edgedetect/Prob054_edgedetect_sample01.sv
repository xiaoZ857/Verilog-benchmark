
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);
reg [7:0] prev;
reg [7:0] edge_flag;

always @(posedge clk) begin
    edge_flag <= in & ~prev;
    pedge <= edge_flag;
    prev <= in;
end

endmodule
