
module TopModule (
    input [2:0] in,
    output reg [1:0] out
);

always @(*) begin
    case (in)
        3'b000: out = 2'b00; // No '1's
        3'b001, 3'b010, 3'b100: out = 2'b01; // One '1'
        3'b011, 3'b101, 3'b110: out = 2'b10; // Two '1's
        3'b111: out = 2'b11; // Three '1's
        default: out = 2'b00; // Default case (should not occur)
    endcase
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
