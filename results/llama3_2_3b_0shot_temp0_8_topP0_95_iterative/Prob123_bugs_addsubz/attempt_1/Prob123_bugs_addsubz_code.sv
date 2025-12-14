
module TopModule (
  input do_sub,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);
// Implement the Verilog module based on the following description.
synthesis verilog_input_version verilog_2001
module top_module (
    input do_sub,
    input [7:0] a,  // changed input to reg (not just input) because we are storing value in it 
    input [7:0] b,
    output reg [7:0] out, 
    output reg result_is_zero
);

// always statement is used for synchronous behavior but here we have *(*) which means any change 
// regardless of the clock signal so this condition will not be true as soon as the a or b values change.
always @(*) begin
    case (do_sub)
        0: out = $signed(a) + $signed(b); // casting to signed 
        1: out = $signed(a) - $signed(b);
        default: 
            out = $unsigned(a) - $unsigned(b);  // subtract unsigned value from unsigned
    endcase

    if (out == 0)
        result_is_zero = 1;
end

// add another always block to handle subtraction when do_sub is 1
always @(*) begin
    if (do_sub == 1)
        out = $unsigned(a) - $unsigned(b);
end

// VERILOG-EVAL: endmodule not found
