
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
        case (do_sub)
            0: out = a+b;
            1: out = a-b;
            default: out = a; // handle the case when both inputs are zero
        endcase

        if (~out)
            result_is_zero = 1;
    end

endmodule
