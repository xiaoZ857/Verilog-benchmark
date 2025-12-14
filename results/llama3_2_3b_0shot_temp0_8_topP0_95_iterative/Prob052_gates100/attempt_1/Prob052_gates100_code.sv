
// Define the inputs to the module with a positive clock/clk trigger
input [99:0] clk;
input [99:0] in;

// Outputs of the AND gate
output out_and;

// Outputs of the OR gate
output out_or;

// Output of the XOR gate
output out_xor;

module TopModule (
  input clk,
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);

    // Always block to create combinational logic
    always @(*) begin

        // Calculate the AND result
        out_and = ~in;
        
        // Calculate the OR result
        out_or = ~in;

        // Calculate the XOR result
        out_xor = in ^ (~in);
    
    end
    
endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
