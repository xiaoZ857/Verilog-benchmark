
// Prob115_shift18_test.sv:1: error: `timescale directive can not be inside a module definition.

module TopModule (
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q
);

always @(posedge clk) begin
  if (load) begin
    q <= data;
  end else if (ena) begin
    case (amount)
      2'b00: // shift left by 1 bit
        q <= data << 1;
      2'b01: // shift left by 8 bits
        q <= data << 8;
      2'b10: // shift right by 1 bit (arithmetic)
        q <= (data >> 1) | ((data[63]) ? 64'h80_00_00_00 : 0); // sign extension
      2'b11: // shift right by 8 bits (arithmetic)
        q <= (data >> 8) | ((data[63] ? 7 : 0) << 56); // adjust sign extension for 8 bits
    endcase
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
