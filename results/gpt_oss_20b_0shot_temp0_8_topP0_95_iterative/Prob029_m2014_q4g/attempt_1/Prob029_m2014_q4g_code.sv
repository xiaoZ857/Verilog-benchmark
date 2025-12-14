
// -----------------------------------------------------------
//  TopModule
//  ---------
//  Implements:   out = XNOR(in1, in2) XOR in3
//  Description:  Two‑input XNOR feeds into a two‑input XOR.
//                The second XOR input is in3. The XOR output is out.
//  Notes:        Purely combinational – no clock is required.
// -----------------------------------------------------------

module TopModule (
    input  logic in1,   // First input to the XNOR
    input  logic in2,   // Second input to the XNOR
    input  logic in3,   // Second input to the XOR
    output logic out    // XOR output
);

    // Continuous assignment – purely combinational logic
    assign out = (~(in1 ^ in2)) ^ in3;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
