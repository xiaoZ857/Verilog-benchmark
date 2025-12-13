
module TopModule (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

  // Calculate the starting bit position for the 4-bit selection
  // Since each selection is 4 bits, we multiply sel by 4
  // The result will be a 10-bit value (8-bit sel * 2 gives 10 bits max)
  wire [9:0] start_bit = sel * 4;
  
  // Extract the 4 bits starting from the calculated position
  assign out = in[start_bit + 3 : start_bit];
  
endmodule
