
module TopModule (
  input clk,
  input reset,
  input w,
  output z
);
assign z = (w & ~z) | (~w & z);

always @(posedge clk or reset) begin
    if (reset)
        z <= 1'b0;
    else
        case(z)
            1'b0: z <= w;
            1'b1: z <= w;
            default: z <= w;
        endcase
endmodule
