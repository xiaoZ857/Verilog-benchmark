
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);
reg [7:0] in_prev;
reg [7:0] edge_detected;

always @(posedge clk) begin
  in_prev <= in;
  edge_detected <= in & ~in_prev;
  pedge <= edge_detected;
end

endmodule
