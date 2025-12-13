
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);
  always @(*) begin
    case (y)
      3'b000: Y2 = 1'b0; // A -> next y[2] is 0 for both w=0 (B:001) and w=1 (A:000)
      3'b001: Y2 = w ? 1'b0 : 1'b0; // B -> w=1: D(011), w=0: C(010) -> y[2] is 0 for both
      3'b010: Y2 = w ? 1'b0 : 1'b1; // C -> w=1: D(011), w=0: E(100) -> y[2]=0 for w=1, y[2]=1 for w=0
      3'b011: Y2 = w ? 1'b0 : 1'b1; // D -> w=1: A(000), w=0: F(101) -> y[2]=0 for w=1, y[2]=1 for w=0
      3'b100: Y2 = w ? 1'b0 : 1'b1; // E -> w=1: D(011), w=0: E(100) -> y[2]=0 for w=1, y[2]=1 for w=0
      3'b101: Y2 = w ? 1'b0 : 1'b0; // F -> w=1: D(011), w=0: C(010) -> y[2]=0 for both
      default: Y2 = 1'b0;
    endcase
  end
endmodule
