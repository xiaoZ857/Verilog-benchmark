
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
        4'b0000 : pos = 2'b00; // Explicitly handle case where all bits are zero
        default: pos = 2'bxx;  // This line can be removed as we've covered all cases.
    endcase
end

endmodule
