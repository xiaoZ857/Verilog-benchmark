
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

  // Concatenate all inputs and add two 1 bits at the end
  wire [31:0] concatenated = {f, e, d, c, b, a, 2'b11};
  
  // Split the 32-bit concatenated value into four 8-bit outputs
  assign w = concatenated[31:24];
  assign x = concatenated[23:16];
  assign y = concatenated[15:8];
  assign z = concatenated[7:0];

endmodule
