
module TopModule (
    input a,      // Input signal
    input b,      // Input signal
    output out_and,  // Output: a and b
    output out_or,   // Output: a or b
    output out_xor, // Output: a xor b
    output out_nand, // Output: a nand b
    output out_nor,  // Output: a nor b
    output out_xnor, // Output: a xnor b
    output out_anotb  // Output: a and-not b
);

    assign out_and = a & b;          // (1) out_and: a and b
    assign out_or = a | b;           // (2) out_or: a or b
    assign out_xor = ~a & b;         // (3) out_xor: a xor b
    assign out_nand = ~(a | b);      // (4) out_nand: a nand b
    assign out_nor = ~(a & b);       // (5) out_nor: a nor b
    assign out_xnor = ~a & ~b;        // (6) out_xnor: a xnor b
    assign out_anotb = a & (~b);      // (7) out_anotb: a and-not b

endmodule

// VERILOG-EVAL: errant inclusion of module definition
