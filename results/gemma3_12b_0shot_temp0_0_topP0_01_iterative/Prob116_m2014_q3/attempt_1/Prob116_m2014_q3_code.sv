
module TopModule (
  input [4:1] x,
  output logic f
);

  always_comb begin
    if (x[1] == 0 && x[2] == 0) begin
      f = 0;
    end else if (x[1] == 0 && x[2] == 1) begin
      f = 1;
    end else if (x[1] == 1 && x[2] == 1) begin
      f = 1;
    end else if (x[1] == 1 && x[2] == 0) begin
      f = 0;
    end else begin
      f = 0; // Default case, handles the don't cares.  Could also be 1.
    end
  end

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
