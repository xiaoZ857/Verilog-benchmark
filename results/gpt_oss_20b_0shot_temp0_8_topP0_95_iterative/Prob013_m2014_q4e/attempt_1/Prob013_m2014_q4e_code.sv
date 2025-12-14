
// ---------------------------------------------------------------------
// 2‑input NOR gate
// ---------------------------------------------------------------------
//  out = NOT (in1 OR in2)
// ---------------------------------------------------------------------
module TopModule (
    input  logic in1,      // first input
    input  logic in2,      // second input
    output logic out       // NOR output
);

    // Combinational assignment – the simplest way to describe a NOR gate
    assign out = ~(in1 | in2);

    // (Optional) equivalent always_comb form:
    // always_comb begin
    //     out = ~(in1 | in2);
    // end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
