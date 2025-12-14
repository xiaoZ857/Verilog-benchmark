
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);
logic [1:0] state;

// One‑hot encoding: A = 2'b01, B = 2'b10
assign z = (state[0] & x) | (state[1] & ~x);

always_ff @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b01; // reset to state A
    else begin
        if (state[0] && x)       // A --x=1--> B
            state <= 2'b10;      // go to state B
        else
            state <= state;      // otherwise stay in current state
    end
end

endmodule
