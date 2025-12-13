
module TopModule (
  input d,
  input ena,
  output logic q
);
always @(ena or d) begin
    if (ena == 1) begin
        q <= d;
    end
end

q = 0; // Initial condition

// VERILOG-EVAL: endmodule not found
