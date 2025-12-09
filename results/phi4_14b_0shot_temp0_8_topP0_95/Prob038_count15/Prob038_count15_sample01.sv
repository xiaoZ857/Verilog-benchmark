
module TopModule (
    input clk,
    input reset,
    output reg [3:0] q
);

    // Always block triggered on the positive edge of the clock or reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Synchronous reset to 0 when reset is high
            q <= 4'b0000;
        end else begin
            // Increment the counter
            q <= q + 1;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
