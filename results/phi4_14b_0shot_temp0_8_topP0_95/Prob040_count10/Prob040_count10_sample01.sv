
module TopModule (
    input wire clk,
    input wire reset,
    output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Synchronous active-high reset sets the counter to 0
        q <= 4'b0000;
    end else begin
        // Increment the counter
        if (q == 4'b1001) begin
            // If the current count is 9, wrap around to 0
            q <= 4'b0000;
        end else begin
            // Otherwise, increment the counter
            q <= q + 1;
        end
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
