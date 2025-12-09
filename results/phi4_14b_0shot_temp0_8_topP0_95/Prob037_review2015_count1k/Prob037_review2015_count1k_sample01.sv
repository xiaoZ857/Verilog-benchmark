
module TopModule (
    input clk,
    input reset,
    output reg [9:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset the counter to 0 on a high reset signal
        q <= 10'b0000000000;
    end else begin
        // Increment the counter unless it reaches 999, then wrap around to 0
        if (q == 10'd999) begin
            q <= 10'b0000000000;
        end else begin
            q <= q + 1;
        end
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
