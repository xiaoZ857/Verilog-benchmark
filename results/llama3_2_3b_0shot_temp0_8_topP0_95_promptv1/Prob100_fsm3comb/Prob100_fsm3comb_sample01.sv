
module TopModule (
  input in,
  input [1:0] state,
  output reg [1:0] next_state,
  output out
);
assign next_state = {state[1], state[0]};
assign out = {out == 2'b00 : (next_state != 2'b01) | (next_state != 2'b10), 
               out == 2'b01 : (next_state != 2'b00) | (next_state != 2'b11),
               out == 2'b10 : (next_state != 2'b00) | (next_state != 2'b11),
               out == 2'b11 : (next_state != 2'b01) | (next_state != 2'b10)};

// VERILOG-EVAL: endmodule not found
