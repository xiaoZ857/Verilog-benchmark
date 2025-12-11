
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
        // Default assignment for z
        z <= 1'b0;
    end
end

endmodule
