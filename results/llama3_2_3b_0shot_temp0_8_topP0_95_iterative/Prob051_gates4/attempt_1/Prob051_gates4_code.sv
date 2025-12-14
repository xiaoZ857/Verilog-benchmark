
module TopModule (
    input [3:0] in,
    output [3:0] out_and,
    output [3:0] out_or,
    output [3:0] out_xor
);

// Define the AND gate
assign out_and = {in[2], in[1], in[0], 0};

// Define the OR gate
assign out_or = {$range(in[3:1]), $range(in[2:0])};

// Define the XOR gate
assign out_xor = {in[1], !in[0], !in[2], !in[3]};

endmodule

// VERILOG-EVAL: errant inclusion of module definition
