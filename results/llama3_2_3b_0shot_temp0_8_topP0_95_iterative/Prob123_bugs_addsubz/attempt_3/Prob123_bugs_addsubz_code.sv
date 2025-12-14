
module TopModule (
  input do_sub,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);
always @(*) begin
    case (do_sub)
        0: out = $signed(a) + $signed(b); // casting to signed 
        1: out = $signed(a) - $signed(b);
        default: 
            out = $unsigned(a) - $unsigned(b);  // subtract unsigned value from unsigned
    endcase

    if (do_sub == 0)
        result_is_zero = 1;
end

always @(*) begin
    if (do_sub == 1)
        out = $signed($unsigned(a) - $unsigned(b)); // cast a and b to signed before subtraction
end

if (~out) 
    result_is_zero = 1;


// VERILOG-EVAL: endmodule not found
