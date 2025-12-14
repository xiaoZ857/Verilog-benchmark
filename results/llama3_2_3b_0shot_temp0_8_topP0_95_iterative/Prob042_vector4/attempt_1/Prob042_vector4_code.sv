
// Module for sign-extending an 8-bit number to 32 bits
module TopModule(
    // 8-bit input number
    input [7:0] in,

    // 32-bit output with extended number and replicated sign bit
    output [31:0] out
);

    // Sign extension logic
    reg [1:0] sign_ext;

    assign
        sign_ext = (in[0]) ? {24{in[0]}};
        out = {sign_ext, in};

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
