
module TopModule (
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q
);

  // Generate enable signals for upper digits
  assign ena[1] = (q[3:0] == 4'd9);    // Enable tens when ones = 9
  assign ena[2] = (q[3:0] == 4'd9) & (q[7:4] == 4'd9);    // Enable hundreds when ones=9 and tens=9
  assign ena[3] = (q[3:0] == 4'd9) & (q[7:4] == 4'd9) & (q[11:8] == 4'd9);    // Enable thousands when ones=9, tens=9, and hundreds=9

endmodule
