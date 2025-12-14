
// Module: TopModule
// Description: Logical AND operation between a NOT-x (x') and x
module TopModule (
  // Inputs:
    input logic x, // Positive clock/clk triggered
    input logic y, // Positive clock/clk triggered
    
  // Output:
    output logic z // Not positive edge-triggered
);

// Boolean function: z = (x^y) & x
logic intermediate;
assign intermediate = ~(x);
assign z = (intermediate & x);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
