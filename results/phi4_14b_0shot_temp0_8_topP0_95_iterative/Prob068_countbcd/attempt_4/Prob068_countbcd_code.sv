
module TopModule (
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Synchronous active-high reset
        q <= 16'b0000_0000_0000_0000;
        ena <= 3'b000;  // Reset all enable signals
    end else begin
        reg carry_tens, carry_hundreds, carry_thousands;

        // Handle the ones digit
        if (q[3:0] == 4'd9) begin
            q[3:0] <= 4'b0000;
            carry_tens = 1;  // Carry to tens
        end else {
            q[3:0] <= q[3:0] + 1;
            carry_tens = 0;
        }

        // Handle the tens digit with potential carry from ones digit
        if (carry_tens) begin
            if (q[7:4] == 4'd9) begin
                q[7:4] <= 4'b0000;
                carry_hundreds = 1;  // Carry to hundreds
            end else {
                q[7:4] <= q[7:4] + 1;
                carry_hundreds = 0;
            }
        end else begin
            q[7:4] <= q[7:4]; // No change if no carry
        end

        // Handle the hundreds digit with potential carry from tens digit
        if (carry_hundreds) begin
            if (q[11:8] == 4'd9) begin
                q[11:8] <= 4'b0000;
                carry_thousands = 1;  // Carry to thousands
            end else {
                q[11:8] <= q[11:8] + 1;
                carry_thousands = 0;
            }
        end else begin
            q[11:8] <= q[11:8]; // No change if no carry
        end

        // Handle the thousands digit with potential carry from hundreds digit
        if (carry_thousands) begin
            if (q[15:12] == 4'd9) begin
                q[15:12] <= 4'b0000;  // Reset to zero after reaching 9999
            end else {
                q[15:12] <= q[15:12] + 1;
            }
        end

        // Set enable signals based on carry flags
        ena[3] = carry_thousands; // Enable thousands digit increment
        ena[2] = carry_hundreds;  // Enable hundreds digit increment
        ena[1] = carry_tens;      // Enable tens digit increment
    end
end

endmodule
