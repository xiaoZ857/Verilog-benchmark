
module TopModule (
  input in,
  output out
);
// Define the NOT gate module
module NotGate(
    // Input signal
    input in,

    // Output signal
    output out
);

    // Assign the NOT operation to the output
    assign out = ~in;

endmodule // End of NotGate module definition

// VERILOG-EVAL: abnormal backticks count
