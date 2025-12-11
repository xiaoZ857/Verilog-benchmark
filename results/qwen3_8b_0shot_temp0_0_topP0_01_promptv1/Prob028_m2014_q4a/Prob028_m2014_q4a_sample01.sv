
module TopModule (
  input d,
  input ena,
  output logic q
);
always @(ena) begin
    if (ena)
        q = d;
end
endmodule
