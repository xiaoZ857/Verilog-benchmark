
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);
always @(posedge clk) begin
    if ((a & ~b) || (~c & b))
        out <= 1'b1;
    else
        out <= 1'b0;
end
endmodule
