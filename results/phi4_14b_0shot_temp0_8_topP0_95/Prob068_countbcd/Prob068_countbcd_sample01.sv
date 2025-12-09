
module TopModule (
  input clk,
  input reset,
  output [3:1] ena, // Enable signals for digits [7:4], [11:8], and [15:12]
  output reg [15:0] q  // 4 BCD digits: q[3:0], q[7:4], q[11:8], q[15:12]
);

  wire carry1, carry2, carry3;

  // Always block for synchronous reset and counter logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset all BCD digits to zero on active-high reset
      q <= 16'b0000_0000_0000_0000;
    end else begin
      // Increment the ones digit and handle carries
      if (q[3:0] == 4'b1001) begin
        q[3:0] <= 4'b0000; // Reset ones digit on max value
        carry1 <= 1;        // Set carry to increment tens digit
      end else begin
        q[3:0] <= q[3:0] + 1;
        carry1 <= 0;        // No carry out if less than 9
      end

      // Increment the tens digit and handle carries
      if (carry1) begin
        if (q[7:4] == 4'b1001) begin
          q[7:4] <= 4'b0000;
          carry2 <= 1;       // Set carry to increment hundreds digit
        end else begin
          q[7:4] <= q[7:4] + 1;
          carry2 <= 0;
        end
      end

      // Increment the hundreds digit and handle carries
      if (carry2) begin
        if (q[11:8] == 4'b1001) begin
          q[11:8] <= 4'b0000;
          carry3 <= 1;       // Set carry to increment thousands digit
        end else begin
          q[11:8] <= q[11:8] + 1;
          carry3 <= 0;
        end
      end

      // Increment the thousands digit if needed
      if (carry3) begin
        if (q[15:12] == 4'b1001) begin
          q[15:12] <= 4'b0000; // Reset on overflow, no carry beyond this
        end else begin
          q[15:12] <= q[15:12] + 1;
        end
      end
    end
  end

  // Assign enable signals based on the carry outputs
  assign ena[3] = carry3; // Enable increment for thousands digit
  assign ena[2] = carry2; // Enable increment for hundreds digit
  assign ena[1] = carry1; // Enable increment for tens digit

endmodule

// VERILOG-EVAL: errant inclusion of module definition
