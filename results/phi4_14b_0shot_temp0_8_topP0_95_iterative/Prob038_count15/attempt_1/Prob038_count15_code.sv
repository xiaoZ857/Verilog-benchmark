
module TopModule (
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Synchronous active-high reset, set counter to 0
        q <= 4'b0000;
    end else begin
        // Increment the counter on each clock edge
        q <= q + 1;
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
