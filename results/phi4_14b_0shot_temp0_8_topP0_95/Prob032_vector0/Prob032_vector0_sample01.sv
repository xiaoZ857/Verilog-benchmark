
module TopModule (
    input [2:0] vec,      // Input 3-bit vector
    output reg [2:0] outv,// Output 3-bit vector
    output o2,           // Separate output for bit 2
    output o1,           // Separate output for bit 1
    output o0            // Separate output for bit 0
);

// Connect the input vector to the output vector directly
assign outv = vec;

// Directly assign each bit of the input vector to the corresponding separate outputs
assign o2 = vec[2];
assign o1 = vec[1];
assign o0 = vec[0];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
