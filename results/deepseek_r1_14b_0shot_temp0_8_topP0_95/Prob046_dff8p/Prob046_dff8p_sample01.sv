
module TopModule (
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q
);

always_ff @(negedge clk) begin
    if (reset)
        q <= 8'b00110100; // 0x34 in binary
    else
        q <= d;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
