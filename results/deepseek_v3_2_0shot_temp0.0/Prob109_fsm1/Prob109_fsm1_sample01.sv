
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);
reg state, next_state;
localparam A = 1'b0, B = 1'b1;

always @(*) begin
    case (state)
        A: next_state = in ? A : B;
        B: next_state = in ? B : A;
        default: next_state = B;
    endcase
end

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= B;
    else
        state <= next_state;
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
