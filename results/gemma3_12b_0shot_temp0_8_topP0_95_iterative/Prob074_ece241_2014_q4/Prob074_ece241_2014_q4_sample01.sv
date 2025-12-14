
module TopModule (
  input clk,
  input x,
  output z
);
  // Internal signals
  wire ff1_data, ff2_data, ff3_data;
  wire ff1_out, ff2_out, ff3_out;

  // D Flip-Flops
  always @(posedge clk) begin
    ff1_out <= ff1_data;
    ff2_out <= ff2_data;
    ff3_out <= ff3_data;
  end

  // Gates and Data Inputs for D Flip-Flops
  assign ff1_data = x ^ ff1_out;
  assign ff2_data = x & ~ff2_out;
  assign ff3_data = x | ~ff3_out;

  // NOR Gate to produce output Z
  assign z = ~(ff1_out | ff2_out | ff3_out);

endmodule
