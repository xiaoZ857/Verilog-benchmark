
module TopModule (
  input a, // input signal A
  input b, // input signal B
  input sel_b1, // select bit 1
  input sel_b2, // select bit 2
  output out_assign, // output signal for assign statement
  output reg out_always // output signal for always block
);

// Assign statement implementation
assign out_assign = (sel_b1 && sel_b2) ? b : a;

// Always block implementation
always @(posedge clk)
begin
  if (sel_b1 && sel_b2)
    out_always <= b;
  else
    out_always <= a;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
