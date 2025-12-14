
module TopModule (
    input [3:0] in,
    output reg [1:0] pos
);

always @(*) begin
    casez (in)
        4'b1??? : pos = 2'b11; // If bit[3] is high, set position to 3
        4'b01?? : pos = 2'b10; // If bit[2] is high, set position to 2
        4'b001? : pos = 2'b01; // If bit[1] is high, set position to 1
        4'b0001 : pos = 2'b00; // If bit[0] is high, set position to 0
        default: pos = 2'b00;  // If all bits are zero, set position to 0
    endcase
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
