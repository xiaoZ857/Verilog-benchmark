
module TopModule (
  input d,
  input ena,
  output logic q
);
reg internal q_internal; // Internal signal for storing the value of q

always @(posedge clk or negedge reset) begin
  if (reset) begin
    q_internal <= 0; // Reset the latch to 0
  end else if (ena && !q_internal) begin
    q_internal <= d; // Assign the value of d to q_internal when ena is high and q_internal is low
  end else if (!ena && q_internal) begin
    q_internal <= d; // Assign the value of d to q_internal when ena is low and q_internal is high
  end
end

assign q = q_internal; // No need to invert the internal signal, as it's already done internally

// Add clock and reset inputs here if not provided
input wire clk, reset;

// Example usage:
// TopModule top (
//   .d(data),
//   .ena(enable),
//   .clk(clock),
//   .reset(reset_signal)
// );

endmodule
