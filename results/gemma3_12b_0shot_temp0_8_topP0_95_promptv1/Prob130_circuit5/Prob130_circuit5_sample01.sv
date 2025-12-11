
module TopModule (
  input [3:0] a,
  input [3:0] b,
  input [3:0] c,
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);
always @(*) begin
    case (c)
        0: q = b;
        1: q = e;
        2: q = a;
        3: q = d;
        4: q = d;
        5: q = d;
        6: q = d;
        7: q = d;
        8: q = d;
        9: q = d;
        default: q = d;
    endcase
end
endmodule
