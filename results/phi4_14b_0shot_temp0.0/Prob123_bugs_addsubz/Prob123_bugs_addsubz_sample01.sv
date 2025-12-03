

module TopModule (
  input do_sub,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);

always @(*) begin
    if (do_sub) 
        out = a - b;
    else 
        out = a + b;

    // Check for zero result using bitwise NOR to handle signed numbers correctly
    result_is_zero = ~(|out);  // Set result_is_zero to 1 if all bits of 'out' are 0
end

endmodule
