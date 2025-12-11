
module TopModule (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);
logic [2:0] state;
logic next_state;
logic [2:0] next_state_temp;
assign disc = (state == 3);
assign flag = (state == 6);
assign err = (state == 7);

always_comb begin
  next_state = state;
  case (state)
    3: if (in) next_state = 4; else next_state = 3;
    4: if (in) next_state = 5; else next_state = 3;
    5: if (in) next_state = 6; else next_state = 3;
    6: if (in) next_state = 7; else next_state = 3;
    7: if (in) next_state = 2; else next_state = 2;
    default: if (in) next_state = 2; else next_state = 0;
  endcase
end

always @(posedge clk) begin
  if (reset) begin
    state <= 0;
  end else begin
    state <= next_state;
  end
end

endmodule
