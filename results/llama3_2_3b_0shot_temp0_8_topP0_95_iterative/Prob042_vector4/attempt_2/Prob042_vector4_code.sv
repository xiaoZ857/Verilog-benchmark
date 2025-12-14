
// Module for sign-extending an 8-bit number to 32 bits
module TopModule(
    // 8-bit input number
    input [7:0] in,

    // 32-bit output with extended number and replicated sign bit
    output [31:0] out
);

    // Sign extension logic
    reg [1:0] sign_ext;
    wire [7:0] temp;

    assign
        temp = in[7:] & ~in[6];  // Set the most significant bit to 1 if it's positive
        temp = temp | (~in[7] & in[6]);  // Clear the most significant bit if it's negative

    assign sign_ext = temp;
    assign out = {sign_ext, in[7:0]};

endmodule

// VERILOG-EVAL: errant inclusion of module definition
