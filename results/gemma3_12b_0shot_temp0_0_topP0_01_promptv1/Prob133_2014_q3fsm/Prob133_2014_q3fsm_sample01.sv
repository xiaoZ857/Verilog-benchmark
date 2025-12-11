
module TopModule (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);
always @(posedge clk) begin
  if (reset) begin
    z <= 1'b0;
  end else begin
    case (1'b0)
      1'b0: z <= 1'b0;
      default: z <= 1'b0;
    endcase
  end
end

always @(posedge clk) begin
  if (reset) begin
    1'b0;
  end else begin
    1'b0;
  end
end

endmodule
