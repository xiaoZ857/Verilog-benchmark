

module TopModule (
  input clk,
  input in,
  input reset,
  output out
);

always @(*) begin
    case(in)
        0: out = (reset == 1 ? B : A);
        1: out = (reset == 1 ? B : B);
    endcase
endmodule

assign B = ~A;
assign A = in ^ B;
