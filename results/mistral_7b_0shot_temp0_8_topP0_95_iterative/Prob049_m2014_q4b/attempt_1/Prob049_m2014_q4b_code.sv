
module TopModule (
  input clk,
  input d,
  input ar,
  output logic q
);

reg internal q_reg; // Internal register for q
always @(posedge clk or negedge ar) // Always block triggers on positive edge of clk and any change on ar
begin
  if (~ar) // If reset signal is low, set the flip-flop to 0
    q_reg <= 0;
  else if (d) // If data input and reset are both high, set the flip-flop to 1
    q_reg <= 1;
  else // Otherwise, latch the value of d on positive edge of clk
    q_reg <= d;
end

assign q = q_reg; // Assign output to internal register

endmodule

// VERILOG-EVAL: errant inclusion of module definition
