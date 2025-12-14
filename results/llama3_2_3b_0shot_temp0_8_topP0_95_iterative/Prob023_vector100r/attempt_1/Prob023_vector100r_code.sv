
// Module to reverse the bit ordering of a 100-bit input vector

module TopModule (
  // Input signal (100-bit wide)
  input [99:0] in,
  
  // Output signal (100-bit wide)
  output reg [99:0] out
);

// Logic to reverse bit ordering
assign out = {in[0], in[1:98]};

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
