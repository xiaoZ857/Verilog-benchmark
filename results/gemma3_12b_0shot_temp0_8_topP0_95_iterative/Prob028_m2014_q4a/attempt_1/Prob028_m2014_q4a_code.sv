
module TopModule (
  input d,
  input ena,
  output logic q
);

  always_ff @(posedge clk) begin
    if (ena) begin
      q <= d;
    end
  end

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
