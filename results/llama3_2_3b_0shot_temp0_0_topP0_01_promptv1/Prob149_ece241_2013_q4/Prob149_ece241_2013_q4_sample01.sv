
module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);
assign fr3 = 0;
assign fr2 = 0;
assign fr1 = 0;
assign dfr = 0;

always @(posedge clk) begin
    if (reset)
        fr3 <= 1'b0;
    else if (~s[3] & ~s[2] & s[1])
        fr3 <= 1'b1;
    else if (~s[3] & s[2])
        fr3 <= 1'b0;
    else
        fr3 <= 1'b1;

    if (reset)
        fr2 <= 1'b0;
    else if (~s[2] & s[1])
        fr2 <= 1'b1;
    else if (~s[2])
        fr2 <= 1'b0;
    else
        fr2 <= 1'b1;

    if (reset)
        fr1 <= 1'b0;
    else if (~s[1])
        fr1 <= 1'b1;
    else if (s[1] & ~s[2])
        fr1 <= 1'b0;
    else
        fr1 <= 1'b1;

    if (reset)
        dfr <= 1'b0;
    else if (~s[3] & s[2]) // sensor change indicates previous level was lower than current level
        dfr <= 1'b1;
    else
        dfr <= 1'b0;
end

endmodule
