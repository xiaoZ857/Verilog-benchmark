
// 2‑input NOR gate
//  out = NOT (in1 OR in2)
module TopModule (
    input  logic in1,
    input  logic in2,
    output logic out
);

    // Combinational assignment
    assign out = ~(in1 | in2);   // equivalent to: out = !in1 & !in2;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
