
module TopModule (
  input [6:1] y,
  input w,
  output logic Y2;
);

assign Y2 = (y[5] == 1) || (y[6] == 1);

// ... (rest of the module remains the same)

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
