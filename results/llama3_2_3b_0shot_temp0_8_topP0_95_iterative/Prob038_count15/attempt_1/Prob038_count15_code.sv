
// Define the module
module TopModule(
    // Inputs
    input clk, // Positive clock signal
    input reset, // Active high synchronous reset input
    
    // Outputs
    output reg [3:0] q // 4-bit binary counter value
);

// Instantiate a 4-bit binary counter
reg [3:0] count = 0;
reg [1:0] carry = 0;

// Counter logic
always @(posedge clk) begin
    if (reset) begin // Reset the counter on rising edge of clock when reset is high
        count <= 0;
    else begin // Increment the counter
        // Carry logic
        if (count == 15) begin // 16th bit is always carry
            carry <= 1;
        else begin // Count up in binary
            count <= count + 1;
            carry <= 0;
        end
    end
end

// Output the counter value to q
assign q = {carry, count[2], count[1], count[0]};

endmodule

// VERILOG-EVAL: errant inclusion of module definition
