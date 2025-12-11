
module TopModule (
  input clk,
  input resetn,
  input in,
  output out
);
always @(posedge clk) begin
    if (!resetn)
        q1 <= 1'b0;
    else
        q1 <= in;
end

always @(posedge clk) begin
    if (!resetn)
        q2 <= 1'b0;
    else
        q2 <= q1;
end

always @(posedge clk) begin
    if (!resetn)
        q3 <= 1'b0;
    else
        q3 <= q2;
end

always @(posedge clk) begin
    if (!resetn)
        q4 <= 1'b0;
    else
        q4 <= q3;
end

assign out = q4;

endmodule
