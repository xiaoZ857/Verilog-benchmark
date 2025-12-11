
module TopModule (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);
always @(posedge clk) begin
    if (reset) begin
        disc <= 1'b0;
        flag <= 1'b0;
        err <= 1'b0;
    end else begin
        disc <= 1'b0;
        flag <= 1'b0;
        err <= 1'b0;
    end
end

endmodule
