

module TopModule (
  input clk,
  input in,
  output logic out
);

assign out = (clk && ~out) ^ in;
endmodule
