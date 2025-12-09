

module TopModule (
  input clk,
  input areset,
  input x,
  output z
);

reg [1:0] state;          // state[0] = A, state[1] = B

assign z = (state[0] & x) | (state[1] & ~x);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01;   // reset to state A
    end else begin
        state <= {state[0] & x | state[1],   // next state B
                  state[0] & ~x};            // next state A
    end
end

endmodule
