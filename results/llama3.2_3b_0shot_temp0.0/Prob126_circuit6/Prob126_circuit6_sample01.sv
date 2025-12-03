

module TopModule (
  input [2:0] a,
  output reg [15:0] q
);

reg [15:0] q;
assign q = (a == 3) ? 27d4 : 
           (a == 1) ? aee0 : 
           (a == 2) ? 5a0e : 
           (a == 4) ? 2066 : 
           (a == 5) ? 64ce : 
           1232;
endmodule
