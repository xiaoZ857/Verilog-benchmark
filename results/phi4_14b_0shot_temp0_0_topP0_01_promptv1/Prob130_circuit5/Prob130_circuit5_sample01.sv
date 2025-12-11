
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
        4'b0000: q = b;
        4'b0001: q = e;
        4'b0010: q = a;
        4'b0011: q = d;
        default: q = f; // 'f' is not defined, assuming it's meant to be some constant or error state
    endcase
end
endmodule
