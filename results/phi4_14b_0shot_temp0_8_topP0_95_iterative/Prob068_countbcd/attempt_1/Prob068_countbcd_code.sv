
module TopModule (
    input wire clk,
    input wire reset,
    output reg [3:1] ena,  // Enable signals for tens (ena[3]), hundreds (ena[2]), and thousands (ena[1])
    output reg [15:0] q     // Output register containing the four BCD digits
);

    // Internal registers to hold each digit of the BCD counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Synchronous active-high reset
            q <= 16'b0000_0000_0000_0000;
            ena <= 3'b000;  // Reset all enable signals
        end else begin
            // Handle the ones digit
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'b0000;  // Reset to zero after reaching 9
                ena[1] <= 1'b1;      // Enable tens digit increment
            end else begin
                q[3:0] <= q[3:0] + 1;
                ena[1] <= 1'b0;      // Do not enable if not carrying over
            end

            // Handle the tens digit
            if (ena[1]) begin
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'b0000;
                    ena[2] <= 1'b1;    // Enable hundreds digit increment
                end else begin
                    q[7:4] <= q[7:4] + 1;
                    ena[2] <= 1'b0;    // Do not enable if not carrying over
                end
            end

            // Handle the hundreds digit
            if (ena[2]) begin
                if (q[11:8] == 4'd9) begin
                    q[11:8] <= 4'b0000;
                    ena[3] <= 1'b1;    // Enable thousands digit increment
                end else begin
                    q[11:8] <= q[11:8] + 1;
                    ena[3] <= 1'b0;    // Do not enable if not carrying over
                end
            end

            // Handle the thousands digit
            if (ena[3]) begin
                if (q[15:12] == 4'd9) begin
                    q[15:12] <= 4'b0000;
                end else begin
                    q[15:12] <= q[15:12] + 1;
                end
            end

            // Clear enable signals after handling carry-over for all digits
            if (!(|ena)) ena <= 3'b000;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
