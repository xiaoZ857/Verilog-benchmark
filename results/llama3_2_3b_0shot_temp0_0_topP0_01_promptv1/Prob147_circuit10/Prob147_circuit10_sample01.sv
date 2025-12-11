
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);
assign state = $unsigned(32'd0);
assign q = (state == 32'd1) ? a & b : 1'b0;

always @(posedge clk) begin
    if (reset)
        state <= 32'd0;
    else
        state <= state + 1;
end

endmodule
