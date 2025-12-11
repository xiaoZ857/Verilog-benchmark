
module TopModule (
  input do_sub,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);
always @(*) begin
    case (do_sub)
        1'b0: out = a + b;
        1'b1: out = a - b;
    endcase

    result_is_zero = |out ? 1'b0 : 1'b1; // Using bitwise OR to check if any bit of `out` is 1
end
endmodule
