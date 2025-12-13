
module TopModule (
    input clk,
    input reset,
    output reg [3:0] q
);

    // Always block triggered by positive edge of clock or synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Synchronous reset to 0
            q <= 4'b0000;
        end else begin
            // Increment the counter and wrap around at 10
            if (q == 4'b1001) begin
                q <= 4'b0000; // Reset to 0 when count reaches 9
            end else begin
                q <= q + 1;    // Increment the counter
            end
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
