

module TopModule (
  input d,
  input ena,
  output logic q
);

always @(posedge clk) begin
    if (ena == 1'b1) begin
        q <= d;
    end else begin
        q <= q;
    end
end

assign q = q; // to avoid the "always" block being triggered on a non-clock edge

// VERILOG-EVAL: endmodule not found
