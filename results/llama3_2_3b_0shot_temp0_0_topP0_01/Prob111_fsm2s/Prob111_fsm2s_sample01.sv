

module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

always @(*) begin
    case((j & ~k))
        0: out = 0;
        1: out = 1;
    endcase
endmodule
