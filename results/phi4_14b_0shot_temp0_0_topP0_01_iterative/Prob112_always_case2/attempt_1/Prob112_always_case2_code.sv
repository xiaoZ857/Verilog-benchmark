
module TopModule (
  input [3:0] in,
  output reg [1:0] pos
);

  always @(*) begin
    casez(in)
      4'b1xxx: pos = 2'd3; // If bit[3] is high, position is 3
      4'b01xx: pos = 2'd2; // If bit[2] is high and bit[3] is low, position is 2
      4'b001x: pos = 2'd1; // If bit[1] is high and bits[2], [3] are low, position is 1
      4'b0001: pos = 2'd0; // If bit[0] is high and bits[1], [2], [3] are low, position is 0
      default: pos = 2'd0; // If all bits are low, output zero
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
