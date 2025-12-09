

module TopModule (
  input in1,
  input in2,
  output logic out
);

always_ff @(posedge clk) begin
    // Apply a bubble (invert) to in2 before feeding it into the AND gate
    out <= in1 & ~in2;
end

endmodule
