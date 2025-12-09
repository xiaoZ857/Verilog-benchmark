

module TopModule (
  input d,
  input ena,
  output logic q
);

reg q; // internal signal to store the data

always @(posedge clk) begin
  if (ena)
    q <= d;
end

assign q_out = q; // output assignment for q

endmodule
