
module TopModule (
  input clk, // Positive edge triggered clock signal
  input [7:0] d, // Data to be written into the DFFs
  input areset, // Active high asynchronous reset signal
  output reg [7:0] q // Output of all 8 DFFs
);

reg [7:0] q; // Outputs of all 8 DFFs

// Creating 8-bit D flip-flop module with active high asynchronous reset
assign q = {d[7], d[6], d[5], d[4], d[3], d[2], d[1], d[0]};

endmodule // TopModule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
