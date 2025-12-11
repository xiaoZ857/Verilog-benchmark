
module TopModule (
  input clk,
  input enable,
  input S,
  input A,
  input B,
  input C,
  output reg Z
);
assign Z = A[7]*Q[7] + A[6]*Q[6] + A[5]*Q[5] + A[4]*Q[4] + A[3]*Q[3] + A[2]*Q[2] + A[1]*Q[1] + A[0]*Q[0];

assign Q[7] = S;
assign Q[6] = S;
assign Q[5] = S;
assign Q[4] = S;
assign Q[3] = S;
assign Q[2] = S;
assign Q[1] = S;
assign Q[0] = S;

always @(posedge clk)
  if (enable)
    begin
      #10
      for (int i = 7; i >= 0; i--) 
        Q[i + 1] <= Q[i];
    end
  else
    begin
      for (int i = 1; i <= 8; i++)
        Q[i] <= 1'b0;
    end

endmodule
