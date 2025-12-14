
module TopModule (
  input do_sub,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);
always @(*) begin
    // Use signed arithmetic to handle overflow correctly.
    if (do_sub) begin
        {out[7], out} = a - b;  // Perform subtraction with sign extension
    end else begin
        {out[7], out} = a + b;  // Perform addition with sign extension
    end

    // Correct zero flag logic: Check if all bits of 'out' are zero.
    result_is_zero = (out == 8'b0000_0000);
end

endmodule
