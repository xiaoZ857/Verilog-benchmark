

module TopModule (
  input in1,
  input in2,
  output logic out
);

always_ff @(posedge clk) begin
    out <= ~(in1 | in2);
end

endmodule
