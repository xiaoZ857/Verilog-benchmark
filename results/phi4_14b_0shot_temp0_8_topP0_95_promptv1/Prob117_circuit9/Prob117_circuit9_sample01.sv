
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);
always @(posedge clk) begin
    if (a)
        q <= q + 1'b1;
    else
        q <= 3'b000;
end

endmodule
