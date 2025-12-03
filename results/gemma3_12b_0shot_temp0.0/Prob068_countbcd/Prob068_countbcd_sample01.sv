

module TopModule (
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q
);

always @(posedge clk or posedge reset) begin
  if (reset) begin
    q <= 0;
    ena[0] <= 0;
    ena[1] <= 0;
    ena[2] <= 0;
  end else begin
    ena[0] <= 1;
    if (q[3:0] == 9) begin
      q[3:0] <= 0;
      ena[1] <= 1;
    end else begin
      q[3:0] <= q[3:0] + 1;
    end
    
    if (q[7:4] == 9) begin
      q[7:4] <= 0;
      ena[2] <= 1;
    end else begin
      q[7:4] <= q[7:4];
    end
    
    if (q[11:8] == 9) begin
      q[11:8] <= 0;
      ena[3] <= 1;
    end else begin
      q[11:8] <= q[11:8];
    end
    
    if (q[15:12] == 9) begin
      q[15:12] <= 0;
    end else begin
      q[15:12] <= q[15:12];
    end
  end
endmodule
