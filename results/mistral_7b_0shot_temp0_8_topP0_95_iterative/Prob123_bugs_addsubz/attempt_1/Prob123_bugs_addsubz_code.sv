
module TopModule (
  input do_sub,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);
synthesis verilog_input_version verilog_2001
module top_module (
  input do_sub,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);

  always @(posedge clk) begin
      if (do_sub)
          out <= a - b; // Subtraction operation
      else
          out <= a + b; // Addition operation

      if (out == 'b0)
          result_is_zero <= 1'b1; // If the output is zero, set the flag
      else if ((a > b) && do_sub) // Check for overflow during subtraction
          result_is_zero <= 1'b0;
      else
          result_is_zero <= 1'b0; // Otherwise, clear the flag
  end

endmodule
