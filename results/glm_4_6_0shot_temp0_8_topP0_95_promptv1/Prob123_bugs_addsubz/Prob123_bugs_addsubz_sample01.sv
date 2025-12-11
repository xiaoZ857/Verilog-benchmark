
module TopModule (
  input do_sub,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);

always @(*) begin
    case (do_sub)
        0: out = a + b;
        1: out = a - b;
    endcase
    
    // Check if result is zero (use equality comparison, not bitwise NOT)
    result_is_zero = (out == 8'h00);
end
endmodule
