
module TopModule (
  input clk,
  input x,
  output z
);

  reg q1, q2, q3;
  
  // D flip-flops with combinational logic inputs
  always @(posedge clk) begin
    q1 <= x ^ q1;      // XOR gate output
    q2 <= x & ~q2;     // AND gate output
    q3 <= x | ~q3;     // OR gate output
  end
  
  // Three-input NOR gate
  assign z = ~(q1 | q2 | q3);
  
  // Initialize flip-flops to zero
  initial begin
    q1 = 0;
    q2 = 0;
    q3 = 0;
  end

endmodule
