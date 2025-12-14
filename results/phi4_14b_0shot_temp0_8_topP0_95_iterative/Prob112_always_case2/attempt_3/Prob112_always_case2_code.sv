
module TopModule (
  input [3:0] in,
  output reg [1:0] pos
);

always @* begin
    casez (in)
        4'b1??? : pos = 2'b11; // Bit[3] is high, highest priority
        4'b01?? : pos = 2'b10; // Bit[2] is high, next priority
        4'b001? : pos = 2'b01; // Bit[1] is high, next priority
        4'b0001 : pos = 2'b00; // Bit[0] is high, lowest priority
        default: pos = 2'b00;  // If all bits are zero or any non-specified pattern, output position as 0
    endcase
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
