
module TopModule (
  input clk,
  input reset,
  output reg [9:0] q
);
always @(posedge clk or posedge reset) begin
  if (reset) begin
    H <= 3'b000;
    T <= 4'd0; // Change from 6 bits to 4 bits for correct BCD representation.
    B <= 4'd0; // Change from 6 bits to 4 bits for correct BCD representation.
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
          H <= 0; // When it rolls over from 999 to 000, reset the entire counter.
        end
      end
    end
  end
end

// Assign output values to q. Format: [H2:H0,T3:T0,B3:B0]
always @(*) begin
  q[9] = H[2];
  q[8] = H[1];
  q[7] = H[0];
  q[6] = T[3]; // Correctly assign all bits of T.
  q[5] = T[2];
  q[4] = T[1];
  q[3] = T[0];
  q[2] = B[3]; // Correctly assign all bits of B.
  q[1] = B[2];
  q[0] = B[1];
end

endmodule
