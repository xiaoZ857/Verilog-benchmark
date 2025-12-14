
// TopModule.v
// Simple combinational wiring: a → w, b → x, b → y, c → z
// No clock is required because all signals are purely combinational.

module TopModule (
    input  wire a,   // source for w
    input  wire b,   // source for x and y
    input  wire c,   // source for z
    output wire w,   // a → w
    output wire x,   // b → x
    output wire y,   // b → y
    output wire z    // c → z
);

    // Continuous assignments (combinational logic)
    assign w = a;
    assign x = b;
    assign y = b;
    assign z = c;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
