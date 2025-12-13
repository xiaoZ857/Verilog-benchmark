
module TopModule (
  input d,
  input ena,
  output logic q
);
always @(ena) begin
    if (ena) begin
        q <= d;
    end
end

// VERILOG-EVAL: endmodule not found
