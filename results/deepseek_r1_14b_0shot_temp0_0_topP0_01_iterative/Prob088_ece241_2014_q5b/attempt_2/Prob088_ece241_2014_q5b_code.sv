
// This should be at the top of the file, not inside a module
`timescale 1ns / 1ps

module TopModule (
  input clk,
  input areset,
  input x,
  output z
);

  // State storage: 2 bits for one-hot encoding (A=10, B=01)
  reg [1:0] state;
  
  // Next state logic
  always @* begin
    case (state)
      10: begin  // State A
        if (x == 1) 
          next_state = 01;  // Transition to B
        else 
          next_state = 10;  // Stay in A
      end
      01: begin  // State B
        if (x == 1)
          next_state = 01;  // Stay in B
        else 
          next_state = 01;  // Stay in B
      end
    endcase
  end

  // Output logic
  always @* begin
    case (state)
      10: z = x ? 1 : 0;  // State A: z=1 when x=1, else 0
      01: z = ~x ? 1 : 0; // State B: z=1 when x=0, else 0
    endcase
  end

  // Clocking block for state register
  always @(posedge clk or areset) begin
    if (areset) 
      state <= 10;  // Reset to state A (10)
    else 
      state <= next_state;
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
