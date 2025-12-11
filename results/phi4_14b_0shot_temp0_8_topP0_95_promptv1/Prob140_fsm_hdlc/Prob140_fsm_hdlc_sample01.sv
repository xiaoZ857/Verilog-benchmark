
module TopModule (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);
logic [2:0] state, next_state;

always_ff @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;
    else
        state <= next_state;
end

assign disc = (state == 3'b011);
assign flag = (state == 3'b111);
assign err = (state == 3'b110);

always_comb begin
    case (state)
        3'b000: next_state = in ? 3'b001 : 3'b000;
        3'b001: next_state = in ? 3'b010 : 3'b000;
        3'b010: next_state = in ? 3'b011 : 3'b100;
        3'b011: next_state = in ? 3'b110 : 3'b111; // Transition to error state on 7th '1'
        3'b100: next_state = in ? 3'b101 : 3'b000;
        3'b101: next_state = in ? 3'b110 : 3'b000;
        3'b110: next_state = 3'b110; // Remain in error state
        3'b111: next_state = !in ? 3'b000 : 3'b011; // Loop on '1', exit flag if '0'
        default: next_state = 3'b000;
    endcase
end

endmodule
