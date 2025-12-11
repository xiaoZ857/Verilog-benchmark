
module TopModule (
  input d,
  input ena,
  output logic q
);
always @(posedge clk) begin
    if (ena)
        q <= d;
endmodule
