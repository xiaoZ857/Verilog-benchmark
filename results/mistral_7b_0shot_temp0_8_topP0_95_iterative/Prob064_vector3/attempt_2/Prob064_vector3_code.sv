
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
  concatenated_input <= {a, b, c, d, e, f, 1'b1, 1'b1};
  assign w = concatenated_input[30:24];
  assign x = concatenated_input[23:16];
  assign y = concatenated_input[15:8];
  assign z = concatenated_input[7:0];
end

// Declare a temporary reg variable for the entire 53-bit concatenated input
reg [52:0] concatenated_temp;
assign concatenated_temp = concatenated_input;

// Output assignments are now continuous, need to use '=' instead of '<=', and use the temporary reg variable
assign w = concatenated_temp[30:24];
assign x = concatenated_temp[23:16];
assign y = concatenated_temp[15:8];
assign z = concatenated_temp[7:0];

endmodule
