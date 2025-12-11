
module TopModule (
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q
);
assign q = {data[63],q[62:0]} <= load? {data:q}:amount==2'b00?q<<1:amount==2'b01?q<<8:amount==2'b10?q>>1:amount==2'b11?q>>8; endmodule

// VERILOG-EVAL: endmodule not found
