

module TopModule (
  input clk,
  input enable,
  input S,
  input A,
  input B,
  input C,
  output reg Z
);

always @(posedge clk) begin
  if (enable) begin
    for (integer i = 7; i > 0; i = i - 1) begin
      Q[i] <= Q[i-1];
    end
    Q[0] <= S;
  end
end

always @(A, B, C, Q[0], Q[1], Q[2], Q[3], Q[4], Q[5], Q[6], Q[7]) begin
  case (A, B, C)
    3'000: Z <= Q[0];
    3'001: Z <= Q[1];
    3'010: Z <= Q[2];
    3'011: Z <= Q[3];
    3'100: Z <= Q[4];
    3'101: Z <= Q[5];
    3'110: Z <= Q[6];
    3'111: Z <= Q[7];
    default: Z <= 0;
  endcase
end

endmodule
