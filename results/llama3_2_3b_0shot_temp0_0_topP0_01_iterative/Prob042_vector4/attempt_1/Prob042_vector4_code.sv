
module TopModule (
  input [7:0] in,
  output [31:0] out
);
// Sign-extend an 8-bit number to 32 bits
module sign_extend_module(
    // Input: 8-bit signed number
    input [7:0] in,
    
    // Output: 32-bit signed number with extended sign bit
    output [31:0] out
);

    // Assign the sign bit of the input number to the most significant bits of the output
    assign out[31:16] = {24{in[7]}};

    // Concatenate the remaining bits of the input number to the output
    assign out[15:0] = in;

endmodule

// Create a module that uses the sign-extend module
module TopModule(
    // Input: 8-bit signed number
    input [7:0] in,
    
    // Output: 32-bit signed number with extended sign bit
    output [31:0] out
);

    // Instantiate the sign-extend module
    sign_extend_module sign_extender(
        .in(in),
        .out(out)
    );

endmodule

// VERILOG-EVAL: errant inclusion of module definition
