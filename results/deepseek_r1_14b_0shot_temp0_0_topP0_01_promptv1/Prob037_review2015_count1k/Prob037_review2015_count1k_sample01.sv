
module TopModule (
  input clk,
  input reset,
  output reg [9:0] q
);
always @(posedge clk) begin
    if (reset)
        q <= 1'b0;
    else
        if (q == 999)
            q <= 1'b0;
        else
            q <= q + 1;
end
endmodule
