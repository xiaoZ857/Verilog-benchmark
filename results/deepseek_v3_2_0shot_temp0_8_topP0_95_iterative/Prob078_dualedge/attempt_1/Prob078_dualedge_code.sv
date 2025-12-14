
module TopModule (
  input clk,
  input d,
  output reg q
);
// Use two flip-flops, one triggered on positive edge and one on negative edge.
// Then multiplex between their outputs based on the current clock level.

reg q_pos, q_neg;

always @(posedge clk) begin
    q_pos <= d;
end

always @(negedge clk) begin
    q_neg <= d;
end

always @(*) begin
    if (clk)
        q = q_pos;
    else
        q = q_neg;
end

endmodule
