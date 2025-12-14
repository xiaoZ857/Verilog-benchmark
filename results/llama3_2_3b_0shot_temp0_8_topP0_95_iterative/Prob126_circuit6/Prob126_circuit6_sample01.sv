
module TopModule (
    input [2:0] clk, // input clock signal
    input [3:0] a,   // 4-bit input signal 'a'
    output reg [15:0] q // output signal 'q'
);

always @(posedge clk) begin
    case (a)
        000: q <= 1232;
        001: q <= 5a0e;
        010: q <= 64ce;
        011: q <= c526;
        100: q <= 1232;
        101: q <= aee0;
        110: q <= 27d4;
        111: q <= 5a0e;
        0000: q <= 2066;
        0011: q <= 64ce;
        0101: q <= c526;
        0110: q <= 2f19;
        default: q <= aee0;
    endcase
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
