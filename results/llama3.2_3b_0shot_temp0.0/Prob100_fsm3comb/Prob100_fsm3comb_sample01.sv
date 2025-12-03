

module TopModule (
  input in,
  input [1:0] state,
  output reg [1:0] next_state,
  output out
);

assign next_state = state == 2'b00 ? state : (state == 2'b01 ? 2'b10 : (state == 2'b10 ? 2'b11 : 2'b00));
assign out = ~((in && state == 2'b00) || (in && state == 2'b10)) ? 1'b0 : 1'b1;

// VERILOG-EVAL: endmodule not found
