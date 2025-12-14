
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
reg [52:0] concatenated_input; // Declare a register to store the concatenated input
always @(posedge clk) begin
  concatenated_input <= {a, b, c, d, e, f, 1'b1, 1'b1}; // Concatenate the input vectors and add two extra 1 bits at the end
end

assign w = concatenated_input[30:24]; // Assign values to output vectors using '=' instead of '<='
assign x = concatenated_input[23:16];
assign y = concatenated_input[15:8];
assign z = concatenated_input[7:0];

endmodule
