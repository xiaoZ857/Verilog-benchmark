
module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);
always_comb begin
    if (state == OFF) begin
        if (j == 1)
            next_state = ON;
        else
            next_state = OFF;
    end else begin
        if (k == 1)
            next_state = OFF;
        else
            next_state = ON;
    end
end

always @(posedge clk) begin
    if (reset)
        state <= OFF;
    else
        state <= next_state;
end

assign out = state;

endmodule
