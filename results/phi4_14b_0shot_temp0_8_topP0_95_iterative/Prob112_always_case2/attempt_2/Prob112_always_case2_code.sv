
module TopModule (
  input [3:0] in,
  output reg [1:0] pos
);
always @(*) begin
    casez (in)
        4'b1??? : pos = 2'b11; // If bit[3] is high, highest priority, set position to 3
        4'b01?? : pos = 2'b10; // If bit[2] is high, next priority, set position to 2
        4'b001? : pos = 2'b01; // If bit[1] is high, next priority, set position to 1
        4'b0001 : pos = 2'b00; // If bit[0] is high, lowest priority, set position to 0
        default: pos = 2'b00;  // If all bits are zero, output position as 0
    endcase
end

endmodule
