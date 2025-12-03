

module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);

always @(*) begin
    case (a)
        0: q = 3'b100;
        1: q = {q[1], q[2], 4'b000};
        default: q = 3'b001;
    endcase
endmodule
