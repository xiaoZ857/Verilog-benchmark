
// TopModule: drives the output `one` high at all times
module TopModule (
    output one                     // output port
);

    // Continuous assignment – `one` is always logic ‘1’
    assign one = 1'b1;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
