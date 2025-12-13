
module TopModule (
  input clk,
  input d,
  input r,
  output logic q
);
reg q_reg; // Internal register for storing the Q value

always @(posedge clk) begin
  if (r) // If reset is active high, set Q to 0 when reset is asserted
    q_reg <= 0;
  else if (!r) // Otherwise, assign the input D to the register
    q_reg <= d;
end

assign q = q_reg; // Assign the internal register output as the Q output

endmodule
