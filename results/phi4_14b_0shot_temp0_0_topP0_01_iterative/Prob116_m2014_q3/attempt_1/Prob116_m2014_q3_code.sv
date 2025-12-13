
module TopModule (
    input [4:1] x,
    output logic f
);

assign f = x[3];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
