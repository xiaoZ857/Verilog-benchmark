
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);
reg state, next_state;
  
always @(*) begin
    case (state)
        1'b0: next_state = in ? 1'b0 : 1'b1; // A -> (1->A, 0->B)
        1'b1: next_state = in ? 1'b1 : 1'b0; // B -> (1->B, 0->A)
        default: next_state = 1'b1; // default to B
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 1'b1; // reset to state B
    else
        state <= next_state;
end

assign out = state; // Moore output: state B -> 1, state A -> 0

endmodule
