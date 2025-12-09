
module TopModule (
    input [99:0] a,
    input [99:0] b,
    input sel,
    output [99:0] out
);
    // When sel is 0, output a; when sel is 1, output b.
    assign out = (sel == 0) ? a : b;
endmodule

// VERILOG-EVAL: errant inclusion of module definition
