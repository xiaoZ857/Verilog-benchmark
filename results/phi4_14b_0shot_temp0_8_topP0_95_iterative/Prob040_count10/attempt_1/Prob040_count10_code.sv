
module TopModule (
    input clk,
    input reset,
    output reg [3:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Synchronous active-high reset: set the counter to 0
            q <= 4'b0000;
        end else begin
            // Increment the counter, wrapping back to 0 after reaching 9
            if (q == 4'd9)
                q <= 4'b0000;  // Reset to 0 when count reaches 10
            else
                q <= q + 1'b1; // Increment the counter by 1
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
