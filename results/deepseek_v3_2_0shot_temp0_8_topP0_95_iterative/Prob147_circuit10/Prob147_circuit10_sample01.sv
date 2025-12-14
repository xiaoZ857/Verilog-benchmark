
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);
  reg state;
  reg prev_toggle;
  
  always @(posedge clk) begin
    prev_toggle <= a ^ b;
    if (prev_toggle) begin
      state <= ~state;
    end
  end
  
  assign q = state ^ (a ^ b);
endmodule
