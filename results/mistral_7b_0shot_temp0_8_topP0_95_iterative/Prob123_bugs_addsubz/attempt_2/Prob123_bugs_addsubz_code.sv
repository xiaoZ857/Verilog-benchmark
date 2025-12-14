
module TopModule (
  input do_sub,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);
always @(posedge clk) begin
    case (do_sub)
      0: out <= a + b;
      1: out <= {a[7], b[7]}>>1'b1 & a - b << 8; // Right-shifting 'a' and 'b' to ensure correct output width
    endcase

    if (out === 'h0) // Check for zero value by comparing with hexadecimal zero representation
        result_is_zero <= 1'b1;
    else if ((a > b) && do_sub) // Check for overflow during subtraction
        result_is_zero <= 1'b0;
    else
        result_is_zero <= 1'b0; // Otherwise, clear the flag
end

// VERILOG-EVAL: endmodule not found
