
module TopModule (
  input a,
  input b,
  output out_assign,
  output reg out_alwaysblock
);
always @(posedge clk) begin
  if (a && b)
    out_alwaysblock <= 1'b1;
  else
    out_alwaysblock <= 1'b0;
end

assign out_assign = a & b;

endmodule
