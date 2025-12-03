

module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);

always @(*) begin
  case(q)
    4'd10 : q = 4'd0;
    default : q = q + 1;
  endcase
endmodule

// VERILOG-EVAL: abnormal backticks count
