
module TopModule (
  input clk,
  input reset,
  output reg [9:0] q // q[9:0] represents H[2:0], T[5:0], and B[5:0]
);

  // Registers for hundreds, tens, and units place of BCD
  reg [2:0] H;   // Hundreds place (range 000 to 111 which is 0 to 7 in decimal)
  reg [5:0] T;   // Tens place (BCD range 00000 to 1001 for 0 to 9)
  reg [5:0] B;   // Units place (BCD range 00000 to 1001 for 0 to 9)

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      H <= 3'b000;
      T <= 6'b000000;
      B <= 6'b000000;
    end else begin
      // Increment the BCD counter
      if (B < 6'd9) begin
        B <= B + 1;
      end else begin
        B <= 0;
        if (T < 6'd9) begin
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

  // Assign output values to q. Format: [H2:H0,T5:T0,B5:B0]
  always @(*) begin
    q[9] = H[2];
    q[8] = H[1];
    q[7] = H[0];
    q[6] = T[5];
    q[5] = T[4];
    q[4] = T[3];
    q[3] = T[2];
    q[2] = T[1];
    q[1] = T[0];
    q[0] = B[5]; // Only the MSB of B is assigned for a 10-bit output
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
