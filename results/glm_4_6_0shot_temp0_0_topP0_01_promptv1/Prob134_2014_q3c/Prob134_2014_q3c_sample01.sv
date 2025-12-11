
module TopModule (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);

    always @(posedge clk) begin
        // Logic for Y[0] (next state bit 0)
        Y0 <= (~y[2] & ~y[1] & ~y[0] & x) |  // y=000, x=1
              (~y[2] & ~y[1] & y[0] & ~x) |   // y=001, x=0
              (~y[2] & y[1] & ~y[0] & x) |   // y=010, x=1
              (~y[2] & y[1] & y[0] & ~x) |   // y=011, x=0
              (y[2] & ~y[1] & ~y[0] & ~x);   // y=100, x=0
        
        // Logic for output z
        z <= (~y[2] & y[1] & y[0]) | (y[2] & ~y[1] & ~y[0]);  // y=011 or y=100
    end
endmodule
