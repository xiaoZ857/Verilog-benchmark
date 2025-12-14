
module TopModule (
  input [3:0] in,
  output reg [1:0] pos
);
reg [3:0] bits;
reg [1:0] pos;

assign bits = in;

always @(*)
begin
  if (bits[3]) pos = 2'b01;  // If most significant bit is high, output is 01
  
  else if (bits[2]) pos = 2'b10;  // Next bit from MSB that is not zero
  
  else if (bits[1]) pos = 2'b11;  // Last non-zero bit from MSB
  
  else if (bits[0]) pos = 2'b00;  // If all but one bit are zero, output is 00
  
  else pos = 2'b00;  // Output 00 for input of zeros
  
end

// VERILOG-EVAL: endmodule not found
