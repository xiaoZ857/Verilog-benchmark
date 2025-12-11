
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
assign done = (in[3] == 1'b1) && ((in[2] == 1'b1) & (in[1] == 1'b1));
assign done_next = done;
always @(posedge clk) begin
    if (reset)
        done <= 1'b0;
    else
        done <= done_next;
endmodule
