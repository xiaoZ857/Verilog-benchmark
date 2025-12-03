
module TopModule (
  input clk,
  input d,
  input r,
  output logic q
);

reg q; // internal signal for the flip flop's Q output

always @(posedge clk) begin
  if (!r) // if reset is high (active high), set Q to 0
    q <= 0;
  else // otherwise, assign Q to D
    q <= d;
end

assign q = q; // provide the output Q

endmodule

// VERILOG-EVAL: errant inclusion of module definition
