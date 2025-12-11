
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);
assign out = $signed(in);
always @(posedge clk or reset) begin
    if (reset)
        out <= 1'b0;
    else if ($signed(in) == 2'b00)
        out <= 1'b0;
    else if ($signed(in) == 2'b01)
        out <= 1'b1;
    else if ($signed(in) == 2'b10)
        out <= 1'b1;
    else
        out <= 1'b0;
endmodule
