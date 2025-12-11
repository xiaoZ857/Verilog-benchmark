
module TopModule (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);
assign q = (load) ? data : 
    {q[15:1],{q[31:16],q[47:17]}};
endmodule
