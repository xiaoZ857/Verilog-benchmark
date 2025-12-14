
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);
  reg state;
  wire toggle = a ^ b;
  wire next_state = state ^ toggle;
  
  always @(posedge clk) begin
    state <= next_state;
  end
  
  assign q = next_state;
endmodule
