

module TopModule (
  input in,
  input [3:0] state,
  output reg [3:0] next_state,
  output out
);

assign next_state = state;
assign out = (state == 4'b1000) ? 1 : 0;
endmodule
