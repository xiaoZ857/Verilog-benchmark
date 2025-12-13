
module TopModule (
  input wire clk,
  input wire d,
  input wire r,
  output logic q
);

reg internal q_reg; // Internal register for storing the Q value

always @(posedge clk) begin
  if (!r) // If reset is active high, set Q to 0 when reset is asserted
    q_reg <= 0;
  else
    q_reg <= d; // Otherwise, assign the input D to the register
end

assign q = q_reg; // Assign the internal register output as the Q output

endmodule

// VERILOG-EVAL: errant inclusion of module definition
