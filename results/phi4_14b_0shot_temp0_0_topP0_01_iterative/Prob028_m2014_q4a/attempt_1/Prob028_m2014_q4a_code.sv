
module TopModule (
  input d,
  input ena,
  output logic q
);

  always_ff @(posedge ena) begin
    if (ena) begin
      q <= d;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
