
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
        // Use signed arithmetic for correct overflow handling
        if (do_sub) begin
            {out[7], out} = a - b;  // Handle signed subtraction with overflow
        end else begin
            {out[7], out} = a + b;  // Handle signed addition with overflow
        end

        // Correct zero flag logic
        result_is_zero = (out == 8'b0000_0000);
    end

endmodule
