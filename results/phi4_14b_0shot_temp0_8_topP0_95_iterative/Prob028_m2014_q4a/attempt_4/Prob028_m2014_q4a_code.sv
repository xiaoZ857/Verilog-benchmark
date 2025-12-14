
module TopModule (
  input d,
  input ena,
  output logic q
);

  always @(posedge ena or negedge ena) begin
    if (ena)
      q <= d;  // Capture the value of 'd' at 'q' when 'ena' is high
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
