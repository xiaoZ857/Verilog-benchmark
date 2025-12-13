
// TopModule.v
// A pure combinational pass‑through: out = in
module TopModule (
    input  wire in,   // input signal
    output wire out   // output signal
);

    // Continuous assignment – no clock needed
    assign out = in;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
