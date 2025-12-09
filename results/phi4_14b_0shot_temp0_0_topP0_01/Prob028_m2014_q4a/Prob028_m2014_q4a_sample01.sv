

module TopModule (
  input d,
  input ena,
  output logic q
);

always_ff @(posedge clk or posedge ena) begin
    if (ena)
        q <= d;
end

endmodule
