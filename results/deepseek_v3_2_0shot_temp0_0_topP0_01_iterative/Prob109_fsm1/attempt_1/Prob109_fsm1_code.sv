
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);
reg state, next_state;

always @(*) begin
    case (state)
        1'b0: next_state = in ? 1'b0 : 1'b1; // A -> (in=1: A, in=0: B)
        1'b1: next_state = in ? 1'b1 : 1'b0; // B -> (in=1: B, in=0: A)
        default: next_state = 1'b1;
    endcase
end

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= 1'b1;
    else
        state <= next_state;
end

assign out = state;

endmodule
