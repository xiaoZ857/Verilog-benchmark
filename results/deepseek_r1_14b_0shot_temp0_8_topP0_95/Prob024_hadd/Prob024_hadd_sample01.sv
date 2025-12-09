
module TopModule (
  input a,
  input b,
  output sum,
  output cout
);
    // Compute sum using XOR gate
    assign sum = a ^ b;
    // Compute carry-out using AND gate
    assign cout = a & b;
endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
