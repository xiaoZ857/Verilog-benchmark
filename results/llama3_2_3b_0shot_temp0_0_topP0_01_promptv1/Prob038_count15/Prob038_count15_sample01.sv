
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
assign q = $signed({1'b0, 1'b0, 1'b0, 1'b0});

always @(posedge clk) begin
    if (reset)
        q <= 4'b0000;
    else
        case(q)
            4'b0000: q <= 4'b0001;
            4'b0001: q <= 4'b0010;
            4'b0010: q <= 4'b0100;
            4'b0100: q <= 4'b1000;
            4'b1000: q <= 4'b0000;
            default: q <= 4'b0000;
        endcase
endmodule
