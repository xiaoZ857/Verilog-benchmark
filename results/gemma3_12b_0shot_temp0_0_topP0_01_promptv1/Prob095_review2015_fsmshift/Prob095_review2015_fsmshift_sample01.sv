
module TopModule (
  input clk,
  input reset,
  output shift_ena
);
always @(posedge clk) begin
  if (reset) begin
    shift_ena <= 1'b1;
  end else begin
    shift_ena <= 1'b0;
  end
endmodule
