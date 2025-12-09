
// 2‑input NOR gate – combinational logic
// ---------------------------------------------------
//  in1, in2 : 1‑bit inputs
//  out      : 1‑bit output (logic type)
// ---------------------------------------------------

module TopModule (
    input  in1,
    input  in2,
    output logic out
);

    // Combinational assignment – NOR of in1 and in2
    assign out = ~(in1 | in2);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
