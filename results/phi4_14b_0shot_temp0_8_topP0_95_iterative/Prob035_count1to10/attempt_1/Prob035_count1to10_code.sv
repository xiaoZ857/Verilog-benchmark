
module TopModule (
    input wire clk,
    input wire reset,
    output reg [3:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Active-high synchronous reset, set counter to 1
            q <= 4'b0001;
        end else begin
            if (q == 4'b1010) begin
                // If the current count is 10, wrap around to 1
                q <= 4'b0001;
            end else begin
                // Increment the counter otherwise
                q <= q + 1;
            end
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
