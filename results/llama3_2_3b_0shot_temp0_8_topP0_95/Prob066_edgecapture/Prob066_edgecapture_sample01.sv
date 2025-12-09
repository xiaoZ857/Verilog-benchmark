
module TopModule(
    // Positive edge clock signal
    input clk,
    
    // Active high synchronous reset signal
    input reset,
    
    // Input 32-bit vector
    input [31:0] in,
    
    // Output register to hold the bit changes
    output reg [31:0] out
);

reg [31:0] prev_in;
reg [31:0] prev_out;

always @(posedge clk) begin
    if (reset) begin
        // Reset the module and outputs when reset is active high
        out <= 0;
        prev_in <= 0;
        prev_out <= 0;
        
    end else begin
        // Update previous inputs and outputs on each positive clock edge
        prev_in <= in;
        
        // Check if input has changed
        if (in != prev_in) begin
            // Output 1 until the register is reset
            out <= 1;
        end else begin
            // If no change, output 0
            out <= 0;
        end
        
        // Update previous outputs for next iteration
        prev_out <= out;
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
