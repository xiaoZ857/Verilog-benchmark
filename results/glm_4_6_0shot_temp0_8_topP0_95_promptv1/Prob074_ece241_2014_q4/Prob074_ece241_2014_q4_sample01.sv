
module TopModule (
  input clk,
  input x,
  output z
);

  reg ff1, ff2, ff3;
  reg first_cycle;
  
  // Initial reset logic
  always @(posedge clk) begin
    if (first_cycle) begin
      ff1 <= 1'b0;
      ff2 <= 1'b0;
      ff3 <= 1'b0;
      first_cycle <= 1'b0;
    end else begin
      // XOR gate: x XOR ff1 output
      ff1 <= x ^ ff1;
      
      // AND gate: x AND ~ff2 output
      ff2 <= x & ~ff2;
      
      // OR gate: x OR ~ff3 output
      ff3 <= x | ~ff3;
    end
  end
  
  // Three-input NOR: ~(ff1 | ff2 | ff3)
  assign z = ~(ff1 | ff2 | ff3);
  
  // Initialize first_cycle flag
  initial begin
    first_cycle = 1'b1;
  end
endmodule
