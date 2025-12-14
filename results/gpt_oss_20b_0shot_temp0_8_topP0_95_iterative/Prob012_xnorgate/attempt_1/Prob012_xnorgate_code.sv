
// XNOR gate – purely combinational
module TopModule (
    input  wire a,
    input  wire b,
    output wire out
);

// 2‑input XNOR:  out = NOT (a XOR b)
assign out = ~(a ^ b);        // equivalent to: assign out = a ~^ b;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
