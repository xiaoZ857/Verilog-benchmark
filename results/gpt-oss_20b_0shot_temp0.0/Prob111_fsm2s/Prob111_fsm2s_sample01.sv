

module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

localparam OFF = 1'b0;
localparam ON  = 1'b1;

logic state, next_state;

always_ff @(posedge clk) begin
    if (reset)
        state <= OFF;
    else
        state <= next_state;
end

always_comb begin
    case (state)
        OFF: next_state = j ? ON : OFF;
        ON:  next_state = k ? OFF : ON;
        default: next_state = OFF;
    endcase
end

assign out = state;

endmodule
