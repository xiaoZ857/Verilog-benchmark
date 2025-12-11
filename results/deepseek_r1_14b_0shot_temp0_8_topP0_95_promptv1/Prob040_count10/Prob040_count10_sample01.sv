
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
always @(posedge clk) begin
    if (reset)
        q <= 1'b0;
    else
        if (q == 9)
            q <= 1'b0;
        else
            q <= q + 1;
end
endmodule
