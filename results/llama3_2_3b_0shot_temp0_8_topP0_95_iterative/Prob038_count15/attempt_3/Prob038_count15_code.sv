
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
// Instantiate a 4-bit binary counter
reg [3:0] count = 0;
reg [1:0] carry = 0;

// Counter logic
always @(posedge clk or reset) begin
    if (reset) begin // Reset the counter on rising edge of clock when reset is high
        count <= 0;
    else begin // Increment the counter
        // Carry logic
        if (count == 15) begin // 16th bit is always carry
            carry <= 1;
        else begin // Count up in binary
            count [2:1] <= {count[2], count[1]+1}; // Changed count = count + 1 to count [2:1] <= {count[2], count[1]+1}
            if (count[3]==1) carry <= 1;
            else carry <= 0;
        end
    end
end

// Output the counter value to q
assign q = {carry, count[2], count[1], count[0]};

// VERILOG-EVAL: endmodule not found
