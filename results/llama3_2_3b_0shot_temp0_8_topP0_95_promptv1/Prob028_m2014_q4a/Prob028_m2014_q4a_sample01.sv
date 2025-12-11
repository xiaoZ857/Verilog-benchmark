
module TopModule (
  input d,
  input ena,
  output logic q
);
assign q = (ena) ? d : q;

// VERILOG-EVAL: endmodule not found
