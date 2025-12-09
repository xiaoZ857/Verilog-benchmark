

module TopModule (
  input clk,
  input d,
  output reg q
);

assign q = (clk && d) ^ (~clk && d);
endmodule
