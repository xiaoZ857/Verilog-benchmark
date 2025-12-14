
module TopModule (
    input [7:0] in,
    output reg parity
);

always @(posedge clk) begin
    parity <= ~in; // Initializing parity as inverse of all inputs for the first clock cycle
    always @(negedge clk) begin
        parity <= parity ^ in; // XOR operation to calculate even parity for the rest of the clock cycles
    end
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
