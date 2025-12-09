
module TopModule (
    input clk,
    input reset,
    output reg [3:0] q
);

    // Process block for synchronous design
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset condition: set counter to 1
            q <= 4'b0001;
        end else begin
            // Normal counting operation
            if (q == 4'b1010) begin
                // If the count reaches 10, wrap around back to 1
                q <= 4'b0001;
            end else begin
                // Increment counter by 1
                q <= q + 1;
            end
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
