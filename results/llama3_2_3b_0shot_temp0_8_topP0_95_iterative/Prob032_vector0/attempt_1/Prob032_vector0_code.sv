
module TopModule (
    // 3-bit vector input
    input [2:0] vec,
    
    // Output of the same vector as input
    output [2:0] outv,
    
    // Two separate 1-bit outputs for the vector's bits
    output o2, o1, o0
);

// Shift the input vector to the right by one position and select the last bit
assign o2 = vec[2];

// Select the middle bit of the input vector
assign o1 = vec[1];

// Select the least significant bit of the input vector
assign o0 = vec[0];

// Output of the same vector as input
assign outv = vec;

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
