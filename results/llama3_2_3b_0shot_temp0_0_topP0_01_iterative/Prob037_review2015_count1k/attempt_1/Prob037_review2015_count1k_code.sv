
// Define the module parameters
param period = 1000; // Period in cycles
param max_value = 999; // Maximum value to count

module TopModule (
  input clk,
  input reset,
  output reg [9:0] q
);

// Create a counter variable
reg [max_value:0] counter;

// Initialize the counter to 0 when reset is active high
always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 0;
    end else begin
        // Increment the counter by 1 on each clock edge
        counter <= counter + 1;
        
        // If the counter exceeds max_value, wrap around to 0
        if (counter > max_value) begin
            counter <= 0;
        end
    end
end

// Assign the current value of the counter to q
assign q = counter;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
