
module TopModule (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);
assign disc = (in[4:0] == 5'b11111);
assign flag = (in[4:0] == 6'b111111);
assign err = (in[4:0] >= 7'b1111111);

always @(posedge clk) begin
    if (reset)
        disc <= 1'b0;
        flag <= 1'b0;
        err <= 1'b0;
    else
        disc <= in[4:0] == 5'b11111 ? 1'b1 : 1'b0;
        flag <= in[4:0] == 6'b111111 ? 1'b1 : 1'b0;
        err <= in[4:0] >= 7'b1111111 ? 1'b1 : 1'b0;
end

endmodule
