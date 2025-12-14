
// Define the module
module TopModule (
  input clk,    // Positive clock signal
  input reset,  // Active-high synchronous reset
  output [3:1] ena,   // Enable signals for upper digits
  output reg [15:0] q     // Output BCD counter value
);

// Define constants for the number of bits in each digit
const int Q_LEN = 4;
const int ENA_LEN = 3;

// Initialize counters for each digit
reg [Q_LEN-1:0] q[3:0];
reg [ENA_LEN-1:0] ena[3:1];

// Default values for the enable signals
assign ena[ENA_LEN-1:0] = 1'b0;

// Synchronous active-high reset
always @(posedge clk) begin
  if (reset) begin
    q <= {Q_LEN'default[3:0], default[3:0], default[3:0], default[3:0]};
    ena <= default[ENA_LEN-1:0];
  end else begin
    // Increment the least significant digit on each clock cycle
    for (int i = Q_LEN - 1; i >= 0; i--) begin
      if (q[i] == Q_LEN'default[i]) begin
        q[i] <= {Q_LEN-1'default[i]};
        ena[ENA_LEN-i-1:0] <= default[ENA_LEN-1:0];
      end else begin
        // Carry 1 to the next digit
        if (i < ENA_LEN) begin
          ena[ENA_LEN-i-1:0] <= q[i] + 1'b1;
          q[i] <= {Q_LEN'default[i]};
        end
      end
    end
  end
end

// Assign the output values to the enable and BCD counter signals
assign q = {ena[2:0], q[3:0]};

endmodule

// VERILOG-EVAL: errant inclusion of module definition
