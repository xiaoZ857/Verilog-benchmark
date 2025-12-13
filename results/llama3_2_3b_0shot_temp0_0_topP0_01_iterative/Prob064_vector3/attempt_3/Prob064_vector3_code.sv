
module TopModule (
  input [4:0] a,
  input [4:0] b,
  input [4:0] c,
  input [4:0] d,
  input [4:0] e,
  input [4:0] f,
  output [7:0] w,
  output [7:0] x,
  output [7:0] y,
  output [7:0] z
);
assign w[7:0] = concat_input[29:24];
assign x[7:0] = concat_input[25:20];
assign y[7:0] = concat_input[21:16];
assign z[7:0] = concat_input[17:12];

// Add two 1 bits to the end of each output vector
assign w[31:30] = 1;
assign x[31:30] = 1;
assign y[31:30] = 1;
assign z[31:30] = 1;

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
