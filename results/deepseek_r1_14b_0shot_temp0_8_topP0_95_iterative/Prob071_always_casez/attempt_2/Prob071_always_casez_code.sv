
module TopModule (
  input [7:0] in,
  output reg [2:0] pos
);
// Fixed: Removed timescale directive from inside module and added proper syntax
always @* begin
  casez (in)
    `b00000001: pos = 3'd0; // Bit 0 is the first set bit
    `b00000010: pos = 3'd1;
    `b00000100: pos = 3'd2;
    `b00001000: pos = 3'd3;
    `b00010000: pos = 3'd4;
    `b00100000: pos = 3'd5;
    `b01000000: pos = 3'd6;
    `b10000000: pos = 3'd7;
    default   : pos = 3'd0; // Output 0 if no bits are set
  endcase
endmodule
