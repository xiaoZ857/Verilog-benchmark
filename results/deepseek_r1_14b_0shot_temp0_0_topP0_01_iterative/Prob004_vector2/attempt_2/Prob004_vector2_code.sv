
module TopModule (
  input [31:0] in,
  output [31:0] out
);

  // Reverse byte order for 32-bit vector
  wire [7:0] byte0 = in[7:0];
  wire [7:0] byte1 = in[15:8];
  wire [7:0] byte2 = in[23:16];
  wire [7:0] byte3 = in[31:24];

  // Reassemble bytes in reverse order
  assign out[31:24] = byte3;
  assign out[23:16] = byte2;
  assign out[15:8] = byte1;
  assign out[7:0] = byte0;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
