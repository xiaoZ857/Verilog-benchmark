
module TopModule (
  input do_sub,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);
always @(*) begin
    // Perform the arithmetic operation
    case (do_sub)
        1'b0: out = a + b;
        1'b1: out = a - b;
        // optional: default: out = 8'b0;
    endcase

    // Set the zero flag when the result is zero
    result_is_zero = (out == 8'b0);
end
endmodule
