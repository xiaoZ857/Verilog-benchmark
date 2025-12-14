
module TopModule (
  input clk,
  input reset,
  output reg [9:0] q
);
// Synchronous logic to increment the counter
always @(posedge clk or reset) begin
    if (!reset) {
        count = 0; // Reset the counter to 0 on reset
    } else {
        count <= count + 1;
        
        // Ensure count wraps around after reaching 999
        if (count >= 1000) {
            count = 0; // Reset the counter to 0 on overflow
        }
    }
end

// Output the current count value
assign q = count;

initial begin
    count = 0;
end

// VERILOG-EVAL: endmodule not found
