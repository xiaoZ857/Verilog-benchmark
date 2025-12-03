

module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);

always @(*) begin
    case(y[2])
        0 : Y2 = (w == 0) ? 0 : 1;
        1 : Y2 = (w == 0) ? 1 : 0;
    endcase
endmodule
