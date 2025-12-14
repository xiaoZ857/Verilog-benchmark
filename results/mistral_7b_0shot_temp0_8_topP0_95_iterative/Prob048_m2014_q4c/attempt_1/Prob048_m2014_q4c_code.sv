
module TopModule (
  input wire clk,
  input wire d,
  input wire r,
  output logic q
);

reg q_internal; // Internal signal for the flip-flop's state

always @(posedge clk) begin
  if (!r) // If reset is high (active high), set q to 0
    q_internal <= 0;
  else // Else, latch the input data into the flip-flop
    q_internal <= d;
end

assign q = q_internal; // Assign the internal signal to the output

endmodule

// VERILOG-EVAL: errant inclusion of module definition
