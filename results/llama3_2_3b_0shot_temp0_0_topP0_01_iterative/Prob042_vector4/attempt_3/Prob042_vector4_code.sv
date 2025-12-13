
module TopModule (
  input [7:0] in,
  output [31:0] out
);
// Assign the sign bit of the input number to the most significant bits of the output
assign out[31:16] = {24{in[7]}};

// Concatenate the remaining bits of the input number to the output
assign out[15:0] = in;

endmodule
