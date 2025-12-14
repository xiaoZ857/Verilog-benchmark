
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);
  reg state;
  wire toggle = a ^ b;
  
  always @(posedge clk) begin
    if (toggle) begin
      state <= ~state;
    end
  end
  
  assign q = state ^ (a ^ b);
endmodule
