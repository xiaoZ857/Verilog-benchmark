
module TopModule (
  input do_sub,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);
module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

    always @(*) begin
        if (do_sub == 1'b0) begin
            out = a + b;
        end else begin
            out = a - b; // Assumes two's complement arithmetic for subtraction.
        end

        // Check if the result is zero
        result_is_zero = (out == 8'b0);
    end

endmodule
