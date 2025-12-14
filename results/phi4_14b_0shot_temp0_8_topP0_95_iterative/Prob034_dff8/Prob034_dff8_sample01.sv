
module TopModule (
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

always @(posedge clk) begin
    q <= d; // Capture the inputs on the rising edge of clk
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
