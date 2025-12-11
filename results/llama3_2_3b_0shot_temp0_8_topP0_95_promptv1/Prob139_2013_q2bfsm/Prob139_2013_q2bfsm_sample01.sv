
module TopModule (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);
assign f = (reset) ? 1'b0 : 1;
always @(posedge clk) begin
    if (reset) 
        q <= 1'b0;
    else if ((q == 1'b0) && ((x == 1'b0) && (y == 1'b0)) && (clk == 1))
        q <= x & y;
    else if ((q == 1'b0) && (x == 1'b1) && (y == 1'b0))
        q <= 1'b1;
    else if ((q == 1'b0) && (x == 1'b0) && (y == 1'b1))
        q <= 1'b1;
    else if (q != 1'b0)
        f <= 1'b0;
end
assign g = (reset || (q == 1'b1)) ? 1'b0 : 1'b1;

// VERILOG-EVAL: endmodule not found
