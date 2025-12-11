
module TopModule (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);
assign g[0] = !r[2] & (r[1] | r[0]);
assign g[1] = r[1];
assign g[2] = r[0];
assign g[3] = r[0] & r[1];

always @(posedge clk) begin
    if (!resetn)
        state <= A;
    else if (r[0])
        state <= B;
    else if (r[1])
        state <= C;
    else if (r[2])
        state <= D;
end

always #(.period(1)) @(posedge clk) begin
    case(state)
        A: q <= 1'b0;
        B: q <= 1'b1;
        C: q <= 1'b10;
        D: q <= 1'b11;
    endcase
end

always #(.period(1)) @(posedge clk) begin
    if (state == A)
        if (!resetn)
            g[0] <= 1'b1;
        else
            g[0] <= 1'b0;
    else if (state == B)
        if (!resetn)
            g[1] <= 1'b1;
        else
            g[1] <= 1'b0;
    else if (state == C)
        if (!resetn)
            g[2] <= 1'b1;
        else
            g[2] <= 1'b0;
    else if (state == D)
        if (!resetn)
            g[3] <= 1'b1;
        else
            g[3] <= 1'b0;
end

reg [2:0] state, q;

endmodule
