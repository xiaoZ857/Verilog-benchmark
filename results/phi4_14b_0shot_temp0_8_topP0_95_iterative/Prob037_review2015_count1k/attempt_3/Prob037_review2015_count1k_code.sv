
module TopModule (
  input clk,
  input reset,
  output reg [9:0] q
);
always @(posedge clk or posedge reset) begin
  if (reset) begin
    H <= 3'b000;
    T <= 4'd0;
    B <= 4'd0;
  end else begin
    // Increment the BCD counter
    if (B < 4'd9) begin
      B <= B + 1;
    end else begin
      B <= 0;
      if (T < 4'd9) begin
        T <= T + 1;
      end else begin
        T <= 0;
        if (H < 3'd7) begin
          H <= H + 1;
        end else begin
          H <= 0; // Reset to 0 when it rolls over from 999.
        end
      end
    end
  end
end

always @(*) begin
  q[9] = H[2];
  q[8] = H[1];
  q[7] = H[0];
  q[6] = T[3]; // Assign all bits of T.
  q[5] = T[2];
  q[4] = T[1];
  q[3] = T[0];
  q[2] = B[3]; // Assign all bits of B.
  q[1] = B[2];
  q[0] = B[1]; // Correctly assign the least significant bit of B.
end

endmodule
