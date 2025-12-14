
module TopModule (
    input wire clk,
    input wire reset,
    output reg [3:1] ena,  // Enable signals for tens (ena[3]), hundreds (ena[2]), and thousands (ena[1])
    output reg [15:0] q     // Output register containing the four BCD digits
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Synchronous active-high reset
            q <= 16'b0000_0000_0000_0000;
            ena <= 3'b000;  // Reset all enable signals
        end else begin
            // Initialize carry flags for each digit
            reg carry_tens, carry_hundreds, carry_thousands;

            // Handle the ones digit
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'b0000;  // Reset to zero after reaching 9
                carry_tens <= 1;
            end else begin
                q[3:0] <= q[3:0] + 1;
                carry_tens <= 0;
            end

            // Handle the tens digit
            if (carry_tens) begin
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'b0000;
                    carry_hundreds <= 1;
                end else begin
                    q[7:4] <= q[7:4] + 1;
                    carry_hundreds <= 0;
                end
            end

            // Handle the hundreds digit
            if (carry_hundreds) begin
                if (q[11:8] == 4'd9) begin
                    q[11:8] <= 4'b0000;
                    carry_thousands <= 1;
                end else {
                    q[11:8] <= q[11:8] + 1;
                    carry_thousands <= 0;
                }
            end

            // Handle the thousands digit
            if (carry_thousands) begin
                if (q[15:12] == 4'd9) begin
                    q[15:12] <= 4'b0000;
                end else {
                    q[15:12] <= q[15:12] + 1;
                }
            end

            // Set enable signals based on carry flags
            ena[1] <= carry_tens;      // Enable tens digit increment
            ena[2] <= carry_hundreds;  // Enable hundreds digit increment
            ena[3] <= carry_thousands; // Enable thousands digit increment
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
