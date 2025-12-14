
module TopModule (
    input wire a,
    input wire b,
    input wire sel,
    output wire out
);

// Implementing the multiplexer using conditional operator
assign out = (sel == 1'b0) ? a : b;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
