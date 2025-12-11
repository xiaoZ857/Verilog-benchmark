
module TopModule (
  input in1,
  input in2,
  input in3,
  output logic out
);
assign out = ~(a & b) | c; 
assign d = ~e & f;
always @(posedge clk) begin
    if (reset)
        q <= 1'b0;
    else
        q <= d;
endmodule
