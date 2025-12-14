
module TopModule (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);
module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output wire[7:0] out // Changed from reg to wire
);

assign out = (~sel & a) | (sel & b); 

endmodule
