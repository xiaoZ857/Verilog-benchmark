
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);
reg [1:0] state;
wire [1:0] next_state;

assign next_state = ({2{state[1]}} & {x, ~x}) | ({state[1] ^ (x == 1'b1), ~state[1]} & {~x, x});
assign z = state[1];

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b01; // Reset to A which is 01 in one-hot encoding
    else
        state <= next_state;
end

endmodule
