
module TopModule (
  input clk,
  input slowena,
  input reset,
  output reg [3:0] q
);
assign q = (clk && ~reset) ? $signed(slowena + $signed(q)) : 4'b0000;

always @(posedge clk or posedge slowena)
begin
    if (reset)
        q <= 4'b0000;
    else if (~slowena)
        q <= q + 1;
end

endmodule
