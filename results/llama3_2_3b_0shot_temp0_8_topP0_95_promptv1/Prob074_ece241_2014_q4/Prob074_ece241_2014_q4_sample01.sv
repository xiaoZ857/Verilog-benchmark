
module TopModule (
  input clk,
  input x,
  output z
);
assign z = (x ^ a) & ~b | (~a & b);
 
always @(posedge clk) begin
    if (reset)
        a <= 1'b0;
    else
        a <= x & ~b;
end
 
always @(posedge clk) begin
    if (reset)
        b <= 1'b0;
    else
        b <= ~a & x;
end
 
assign z = (~a | b) & a;

// VERILOG-EVAL: endmodule not found
