
module TopModule (
    input [255:0] in,
    input [7:0] sel,
    output logic out
);

    // The selector 'sel' directly indexes into the 'in' vector.
    // Since 'sel' is 8 bits, it ranges from 0 to 255.
    // This selects the corresponding bit from 'in'.
    assign out = in[sel];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
