
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
assign done = (posedge clk);
assign in[3] == 1'b1, in[2] == 1'b1, in[1] == 1'b1 & done;

always @(posedge clk) begin
    assign out_bytes = {in[2:0], in[1:0], in[0:0]};
end

assign out_bytes != 24'b11111111111111;
endmodule
