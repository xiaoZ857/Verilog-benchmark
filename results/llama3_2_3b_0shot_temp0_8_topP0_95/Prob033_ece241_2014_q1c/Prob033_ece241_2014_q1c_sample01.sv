
// Top Module to add two 8-bit 2's complement numbers and detect overflow
module TopModule (
    input [7:0] a,           // 8-bit signed number (2's complement)
    input [7:0] b,           // 8-bit signed number (2's complement)
    output [7:0] s,         // 8-bit result of addition
    output logic overflow   // signal to indicate whether an overflow has occurred
);

// Calculate the sum and determine if an overflow occurs
always @(posedge clk) begin
    // Check for negative numbers
    logic is_negative_a = (a[7] == '1');
    logic is_negative_b = (b[7] == '1');

    // Determine whether a is greater than or equal to 2^7
    logic is_greater_than_two_to_seventh_power_a =
        !(is_negative_a && (a[6:0] <= 127));

    // Determine whether b is greater than or equal to 2^7
    logic is_greater_than_two_to_seventh_power_b =
        !(is_negative_b && (b[6:0] <= 127));

    // Calculate the sum and check for overflow
    logic carry = a[7] ^ b[7];  // Carry from addition of most significant bits

    s[7] = 1'b0;                // Output least significant bit is always zero
    if (carry) begin         // If there's a carry, set it in the sum and propagate to next bit
        s[6] = '1';              // Carry propagates through all ones
        for (int i = 5; i >= 0; i--) {  // For each of the remaining bits
            if (!is_negative_a && !is_negative_b) {  // If there's no carry from previous bit
                s[i] = a[i] ^ b[i];   // Set sum bit to result of XOR operation
            } else {
                s[i] = (a[i] + b[i]) % 2;
            }
        }
    } else begin               // No carry, simply compute the sum
        for (int i = 5; i >= 0; i--) {  // For each of the remaining bits
            if (!is_negative_a && !is_negative_b) {  // If there's no carry from previous bit
                s[i] = a[i] ^ b[i];   // Set sum bit to result of XOR operation
            } else {
                s[i] = (a[i] + b[i]) % 2;
            }
        }
    end

    overflow <= is_greater_than_two_to_seventh_power_a | is_greater_than_two_to_seventh_power_b;  // Indicate if an overflow has occurred
end

// To instantiate this module, you can connect it like so:
// TopModule clkClk (clk, .a(a), .b(b), .s(s_out), .overflow(overflow_signal));

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
