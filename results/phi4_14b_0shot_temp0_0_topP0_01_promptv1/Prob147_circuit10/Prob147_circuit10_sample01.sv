
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);
logic d;
always @(posedge clk) begin
    if (a & ~b)
        d <= 1'b1;
    else if (~a & b)
        d <= 1'b0;
    else if (a & b)
        d <= ~q;
end

assign state = q;

always @(posedge clk) begin
    q <= d;
end

endmodule
