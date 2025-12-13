
module TopModule (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

  // Calculate the shift amount (sel * 4)
  wire [9:0] shift_amount = sel * 4;
  
  // Shift right by the calculated amount and extract the lower 4 bits
  assign out = (in >> shift_amount)[3:0];
  
endmodule
