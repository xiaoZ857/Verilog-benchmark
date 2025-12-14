
module TopModule (
    input wire clk,       // Clock input
    input wire [7:0] d,   // 8-bit data input
    input wire reset,     // Active-high synchronous reset
    output reg [7:0] q    // 8-bit register output
);

// Sequential logic for the D flip-flops with synchronous reset
always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 8'b00000000; // Set all bits to zero on reset
    end else begin
        q <= d;            // Update register with input data on clock edge
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
