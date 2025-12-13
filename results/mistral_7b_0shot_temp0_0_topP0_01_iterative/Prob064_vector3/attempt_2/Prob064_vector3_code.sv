
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
always @(posedge clk) begin
  reg [29:0] concatenated_input; // 30 bits to store the concatenated input vectors

  concatenated_input <= {a, b, c, d, e, f}; // Concatenate the input vectors
  concatenated_input[28:27] <= 2'b11; // Add two 1 bits at the LSB positions

  assign w = concatenated_input[27:0]; // Assign output vectors
  assign x = concatenated_input[29:27];
  assign y = concatenated_input[30:28];
  assign z = concatenated_input[31:30];
end

endmodule
