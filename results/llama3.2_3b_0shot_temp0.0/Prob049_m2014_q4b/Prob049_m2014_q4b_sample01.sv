

module TopModule (
  input clk,
  input d,
  input ar,
  output logic q
);

always @(posedge clk) begin
    if (ar) 
        q <= 1'b0;
    else
        q <= d;
end

assign q = q; // to avoid latches

// VERILOG-EVAL: endmodule not found
