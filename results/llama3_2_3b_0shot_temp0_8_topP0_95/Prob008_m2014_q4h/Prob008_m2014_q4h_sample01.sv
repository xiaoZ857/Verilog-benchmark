
// Define the module and its inputs, outputs, and signals
module TopModule(
    // Input signal
    input in,

    // Output signal (assigns the same value as the input)
    output out
);

// Assign the output port to the same value as the input port combinationally
assign out = in;

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
