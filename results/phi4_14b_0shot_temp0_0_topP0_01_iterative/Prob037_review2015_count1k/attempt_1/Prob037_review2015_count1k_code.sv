
module TopModule (
    input clk,
    input reset,
    output reg [9:0] q
);

    // Counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 10'b0000000000; // Reset the counter to 0
        end else begin
            if (q == 10'd999) begin
                q <= 10'b0000000000; // Reset to 0 after reaching 999
            end else begin
                q <= q + 1; // Increment the counter
            end
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
