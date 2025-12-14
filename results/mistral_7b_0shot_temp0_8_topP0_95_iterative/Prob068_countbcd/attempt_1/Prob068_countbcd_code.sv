
module TopModule (
    input wire clk,
    input wire reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 4'b0000; // Reset all counters to zero
        ena <= 4'b0000; // All enable signals are off when reset
    end else begin
        // Increment lower digit (ones)
        if (q[3] == 1'b1 && q[2:0] != 4'b1110) begin
            q <= {q[0], q[1], q[2], q[3]+1'b1};
        end

        // Increment upper digit (tens) if lower digit is properly incremented or already at 9
        if ((q[3] == 1'b1 && q[2:0] == 4'b1110) || (ena[0] && q[3] == 9'b1)) begin
            q <= {q[0], q[1], q[2]+1'b1, q[3]};
            ena[1] = 1'b1; // Enable increment of hundreds digit when tens digit is properly incremented or already at 9
        end

        // Increment upper digit (hundreds) if lower and upper digits are properly incremented or already at 99
        if ((ena[0] && ena[1] && q[2] == 9'b1) || (ena[0] && ena[1] && q[3] == 9'b1 && q[2:0] == 4'b1110)) begin
            q <= {q[0], q[1], q[2]+10'b0001, q[3]};
            ena[2] = 1'b1; // Enable increment of thousands digit when hundreds digit is properly incremented or already at 99 or 999
        end
    end
end

// Initialize all enable signals to be off
always @* begin
    if (ena[0] == 1'b0) ena[1:2] <= 1'b0;
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
