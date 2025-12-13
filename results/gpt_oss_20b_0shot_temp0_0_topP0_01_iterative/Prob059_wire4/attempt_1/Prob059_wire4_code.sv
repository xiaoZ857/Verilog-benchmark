
// TopModule.v
// 3‑input, 4‑output module that behaves like wires:
//   a -> w
//   b -> x
//   b -> y
//   c -> z
//
// All signals are combinational (no clock required).

module TopModule (
    input  wire a,   // input a
    input  wire b,   // input b
    input  wire c,   // input c
    output wire w,   // output w
    output wire x,   // output x
    output wire y,   // output y
    output wire z    // output z
);

// Continuous assignments – the outputs are simply wired to the inputs.
assign w = a;   // a -> w
assign x = b;   // b -> x
assign y = b;   // b -> y
assign z = c;   // c -> z

endmodule

// VERILOG-EVAL: errant inclusion of module definition
