
module TopModule (
  input clk,
  input d,
  input r,
  output logic q
);
  logic q_internal;

  always_ff @(posedge clk, posedge r) begin
    if (r) begin
      q_internal <= 1'b0;
    end else begin
      q_internal <= d;
    end
  end

  assign q = q_internal;

// VERILOG-EVAL: endmodule not found
