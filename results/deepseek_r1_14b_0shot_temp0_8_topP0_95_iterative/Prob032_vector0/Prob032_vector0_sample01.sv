
$timescale 1ns / 1ps

module TopModule (
    input [2:0] vec,
    output [2:0] outv,
    output o2,
    output o1,
    output o0
);

// Assign each output to the corresponding bit of vec
assign o0 = vec[0];
assign o1 = vec[1];
assign o2 = vec[2];

// Assign the vector output as the same as input
assign outv = vec;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
