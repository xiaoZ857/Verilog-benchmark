
// Implement the Verilog module based on the following description. Assume that signals are positive clock/clk triggered unless otherwise stated.
// The 7400-series integrated circuits are a series of digital chips with a few gates each. The 7420 is a chip with two 4-input NAND gates.
// Create a module with the same functionality as the 7420 chip. It has 8 inputs and 2 outputs.

module TopModule (
    input p1a,
    input p1b,
    input p1c,
    input p1d,
    output p1y,
    input p2a,
    input p2b,
    input p2c,
    input p2d,
    output p2y
);

// Create 2 instances of the nand_gate module
nand_gate nand1 (p1a, p1b, p1c, p1d, p1y); // For NAND Gate 1 output connected to p1y
nand_gate nand2 (p2a, p2b, p2c, p2d, p2y); // For NAND Gate 2 output connected to p2y

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
