
module TopModule (
  input [31:0] in,
  output [31:0] out
);
  // Intermediate signals to hold the reversed byte order
  wire [7:0] byte0, byte1, byte2, byte3;
  wire [7:0] byte4, byte5, byte6, byte7;
  wire [7:0] byte8, byte9, byte10, byte11;
  wire [7:0] byte12, byte13, byte14, byte15;
  wire [7:0] byte16, byte17, byte18, byte19;
  wire [7:0] byte20, byte21, byte22, byte23;
  wire [7:0] byte24, byte25, byte26, byte27;
  wire [7:0] byte28, byte29, byte30, byte31;

  assign byte0 = in[7:0];
  assign byte1 = in[15:8];
  assign byte2 = in[23:16];
  assign byte3 = in[31:24];

  assign out[7:0] = byte3;
  assign out[15:8] = byte2;
  assign out[23:16] = byte1;
  assign out[31:24] = byte0;

endmodule
