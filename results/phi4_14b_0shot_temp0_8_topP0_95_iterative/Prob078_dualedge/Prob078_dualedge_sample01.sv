
module TopModule (
  input clk,
  input d,
  output reg q
);

  reg reg1;
  reg reg2;

  // Capture input at positive edge of the clock
  always @(posedge clk) begin
      reg1 <= d; // Capture input on rising edge
      q    <= reg1; // Update q with the value captured by reg1
  end

  // Capture input at negative edge of the clock
  always @(negedge clk) begin
      reg2 <= d; // Capture input on falling edge
      q    <= reg2; // Update q with the value captured by reg2
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
