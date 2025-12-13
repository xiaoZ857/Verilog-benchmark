
module TopModule (
  input [3:0] in,
  output reg [1:0] pos
);
always @(*) begin
    case(in)
        4'b1xxx: pos = 2'd3; // Highest priority: bit[3] is high
        4'b01xx: pos = 2'd2; // Next priority: bit[2] is high, bit[3] is low
        4'b001x: pos = 2'd1; // Next priority: bit[1] is high, bits[2], [3] are low
        4'b0001: pos = 2'd0; // Lowest priority: bit[0] is high, bits[1], [2], [3] are low
        default: pos = 2'd0; // If all bits are low or undefined, output zero
    endcase
end

endmodule
