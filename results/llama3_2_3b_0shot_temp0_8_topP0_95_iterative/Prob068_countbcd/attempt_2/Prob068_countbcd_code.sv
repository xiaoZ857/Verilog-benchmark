
module TopModule (
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q
);
// Initialize counters for each digit
reg [Q_LEN-1:0] temp_q[3:0];
reg [ENA_LEN-1:0] ena[3:1];

// Default values for the enable signals
assign ena[ENA_LEN-1:0] = 1'b0;

// Synchronous active-high reset
always @(posedge clk) begin
  if (reset) begin
    temp_q <= {Q_LEN'default[3:0], default[3:0], default[3:0], default[3:0]};
    ena <= default[ENA_LEN-1:0];
  end else begin
    // Increment the least significant digit on each clock cycle
    for (int i = Q_LEN - 1; i >= 0; i--) begin
      if (temp_q[i] == Q_LEN'default[i]) begin
        temp_q[i] <= {Q_LEN-1'default[i]};
        ena[ENA_LEN-i-1:0] <= default[ENA_LEN-1:0];
      end else begin
        // Carry 1 to the next digit
        if (i < ENA_LEN) begin
          // Store carry value in temp_q
          temp_q[i+1] <= {Q_LEN'default[i+1]};
          ena[ENA_LEN-i-1:0] <= q[i] + 1'b1;
          temp_q[i] <= {Q_LEN'default[i]};
        end else begin
          // Carry 1 to BCD value
          temp_q[3] <= {Q_LEN'default[3]};
        end
      end
    end
    // Update q with carry values
    for (int i = Q_LEN - 2; i >= 0; i--) begin
      temp_q[i+1] <= temp_q[i];
    end
    // Assign the output values to the enable and BCD counter signals
    q <= {ena[2:0], ena[ENA_LEN-3:1], temp_q[Q_LEN-4:1]};
  end
end

// Output the BCD value in 15-bit format
assign q = {q[14:10], q[9:5], q[4:0]};

endmodule
