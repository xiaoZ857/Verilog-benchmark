
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);
always_ff @(posedge clk) begin
  // Combinational logic to determine next state
  localparam next_state = {a, b};
  
  // Flip-flop to store current state
  reg [1:0] state_reg;
  
  // Update observable output q
  state_reg <= (next_state != state_reg) ? state_reg : case(next_state)
    2'b00: 2'b00;
    2'b01: 2'b10;
    2'b11: 2'b11;
    default: 2'b00;
  endcase;
  
  // Update observable output q
  q <= state_reg;

endmodule
